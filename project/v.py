import argparse
import jsonschema
import json5


__doc__ = """ """

wavejson_schema = {         		#type 검증
	"type": "object",       		#유효한 데이터 타입을 명시
	"properties": {         		#유효한 데이터 이름과 값의 쌍들을 명시
		"config": {
			"type": "object",
			"properties": {
				"hscale": {"type": "number"}
			}
		},
		"signal": {
			"type": "array",
			"items": {
				"type": "object",
				"properties": {
					"name": {"type": "string"},
					"wave": {"type": "string"},
					"data": {
						"type": ["array", "string"],
						"items": {"type": "string"}
					},
					"phase": {"type": "number"},
					"period": {"type": "number"}
				},
				"additionalProperties": False
			}
		}
	},
	"additionalProperties": False
}


def get_timescale(module_data):
	for str in module_data:
		if (str.find('`timescale') != -1):
			str = str.strip("\n")
			return str

def get_module_name(module_data):
    for str in module_data:
        if (str.find("module") != -1):
            name = str.replace("\n","")
            name = name.replace(";","").split(" ")
            name = name[1]
            return name.split("(")[0]

def module_instance(module_data):
	m_name = get_module_name(module_data)
	instance_string = m_name + " "
	for str in module_data:
		if (str.find("module") != -1):
			name = str.replace("\n", "")
			name = name.split("(")
			module = name[0].split(" ")
			module = module[1].replace(m_name, "tb")
			name = module + "(" + name[1]

			instance_string = instance_string + name
			break
	return "    " + instance_string

def get_io(module_data):
    inout = []
    for str in module_data:
        if (str.find("input ") != -1): inout.append(str.replace("input", "reg",1))
        elif (str.find("output reg ") != -1): inout.append(str.replace("output reg", "wire",1))
        elif (str.find("output ") != -1): inout.append(str.replace("output", "wire",1))
    return inout

def make_clk(src):
	w = src["wave"]
	if w[0] in "pP": return '''        clk = 1'b1;\n    end\n\n'''
	if w[0] in "nN": return '''        clk = 1'b1;\n    end\n\n'''

def make_initial(src):
	n = src["name"]; w = src["wave"]
	d = src["data"] if "data" in src else None
	prd = src["period"] if "period" in src else 1
	delay = 0; cnt = 0; space = "    "
	re_str = ""
	re_str += (space + "initial begin\n")

	if n == "clk":
		re_str += make_clk(src)
		delay = 5 * prd
		re_str += space + "always #" + str(delay) + " clk = ~clk;\n"

	if d == None:
		for cmd in w:
			if cmd in "0lL":
				re_str += (space + space) + "#" + str(delay) + " " + n + "= 1'b0;\n"
				delay = 10 * prd
			if cmd in "1hH":
				re_str += (space + space) + "#" + str(delay) + " " + n + "= 1'b1;\n"
				delay = 10 * prd
			if cmd in "zx": 
				re_str += (space + space) + "#" + str(delay) + " " + n + "= 1'b" + cmd + ";\n"
				delay = 10 * prd
			if cmd == ".": delay = delay + 10 * prd
			
		re_str += space + "end\n"
	else:
		if type(d) == str:
			d = d.split(" ")
			short = min(len(w), len(d))
			for i in range(short):
				if w[i] == ".":
					delay = delay + 10 * prd
				else:
					bit = len(d[cnt])
					re_str += space*2 + "#" + str(delay) + " " + n + " = " + str(bit) + "'b"+ d[cnt] + ";\n"
					cnt += 1
					delay = 10 * prd
			re_str += space + "end\n"
	return re_str

def stop_time(reg):
	tmp =  reg[0]
	lt = len(tmp["wave"]); pt = tmp["period"] if "period" in tmp else 1
	max_l = lt * pt
	for src in reg[1:]:
		l = len(src["wave"]); p = src["period"] if "period" in src else 1
		l = l * p
		max_l = max(max_l, l)
	re_str = "    initial #" + str(max_l * 10) + " $stop;\n"
	return re_str

def make_initial_vecter(reg):
	res = []
	for src in reg:
		res.append(make_initial(src))
	res.append(stop_time(reg))
	return res

def make_tb(timescale, start, ponts, instance, initial_vecter, end):
	print(timescale)
	print(start)
	for str in ponts:
		if "\n" in str:
			str = str.replace("\n", "")
		print(str)
	print("")
	print(instance + "\n")
	for inits in initial_vecter:
		print(inits)
	print(end)

def sig_info(dict1):	
	list_in = []
	for cmd in (dict1.values() if type(dict1) is dict else ""):
			for k in cmd:
				if (type(k) is list):
					if (k[0] == "input"):
						for i in range(1, len(k)):
							list_in.append(k[i])
	return list_in

def call_json(str):
	with open(str, "r") as fp:
		res = json5.load(fp)
	return res

def call_module(str):
	with open(str, "r") as fp:
		txt = fp.readlines()
	return txt


timescale = "`timescale 1ns/1ps"
start = "module tb();\n"
ponts = None
instance = None
initial_vecter = []
end = "endmodule"

"""src_t = "test.v"
txt = call_module(src_t)
src_j = "test.json"
dict1 = call_json(src_j)
reg = sig_info(dict1)
initial_vecter = make_initial_vecter(reg)
instance = module_instance(txt)
ponts = get_io(txt)
make_tb(timescale, start, ponts, instance, initial_vecter, end)"""


if __name__ == "__main__":
	parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter)
	parser.epilog = __doc__
	parser.add_argument("v", help="Verilog module source file")
	parser.add_argument("src", help="waveJSON source file")
	parser.add_argument("-gtb", "--testbench", action="store_true", 
		help="generate testbench of src")
	args = parser.parse_args()

	if args.testbench:
		txt = call_module(args.vmd)
		dict1 = call_json(args.src)
		reg = sig_info(dict1)

		initial_vecter = make_initial_vecter(reg)
		instance = module_instance(txt)
		ponts = get_io(txt)
		make_tb(timescale, start, ponts, instance, initial_vecter, end)