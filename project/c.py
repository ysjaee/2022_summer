#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import argparse
import itertools
import json5
import jsonschema
import time
import traceback
import sys

__doc__ = """
asciiwave is a tool to convert WaveDrom timing diagrams into ASCII art.

For example:

```
$ cat example/step3.json
{ signal: [
  { name: "clk",  wave: "P......" },
  { name: "bus",  wave: "x.==.=x", data: ["head", "body", "tail", "data"] },
  { name: "wire", wave: "0.1..0." }
]}

$ ./asciiwave example/step3.json
      ┏──┐  ┏──┐  ┏──┐  ┏──┐  ┏──┐  ┏──┐  ┏──┐  
clk : ┛  └──┛  └──┛  └──┛  └──┛  └──┛  └──┛  └──
      xxxxxxxxxxxx╱    ╲╱          ╲╱    ╲xxxxxx
bus : xxxxxxxxxxxx╲head╱╲   body   ╱╲tail╱xxxxxx
      ┐           ┌─────────────────┐           
wire: └───────────┘                 └───────────
```

It supports:
- `wave` commands: `1hHu 0lLd pPnN =2345 zx |`
- The `data` signal property: either an array of strings, or a single string
  containing whitespace-separated values.
- The `hscale` config property: the width of each time unit is `hscale * 2 + 2`
  characters.
- The `period` signal property: this can be a floating point number. The width
  of each wave unit, in characters, is multiplied by `period` and rounded down.
- The `phase` signal property: this can be a floating point number. The signal
  is advanced (if positive) or retarded (negative) by this number of periods.

Watch mode (-w) will continously poll a file on disk, and redraw whenever the
file changes. This can be used interactively alongside a text editor.

"""

# First the key, then the graphics lines
graphics_tiny = [				# 파형 축소버전
	"0+1-rfxz< >|UuDd",
	"_┌─┐┏┓xz< >┆╭┄╰┄",
]

graphics_default = [			# 파형 보통버전
	"0+1-rfxz< >|UuDd",
	" ┌─┐┏┓x_╱ ╲┆╭┄  ",
	"─┘ └┛┗x ╲ ╱┆  ╰┄"
]

graphics_tall = [				# 파형 확대버전
	"0+1-rfxz< >|UuDd",
	" ┌─┐┏┓x ╱ ╲┆╭┄  ",
	" │ │┃┃x─   ┆┆ ┆ ",
	"─┘ └┛┗x ╲ ╱┆  ╰┄"
]

# Define the WaveJSON subset we support
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

# WaveDrom behaviour is surprisingly complex; this is an approximation
def cmd_10(cmd, prev_cmd, width, charwidth, data, put):			# cmd_10과 관련된 것만 판단
	h_cmds = "1hHu"			#1hH는 HIGH값 U도 ,대문자는 화살표로 HIGH 값 표시, HIGH값이지만 점선으로
	l_cmds = "0lLd"			#LOW로 표시
	high = cmd in h_cmds	#high는 cmd가 h_cmds값이 있으면 hight값에는 true 없으면 false
	hard_edge = cmd in "HL" or \
		(high and prev_cmd in (l_cmds + "zx=2345")) or \
		(not high and prev_cmd in (h_cmds + "zx=2345")) or \
		(cmd in "1h" and prev_cmd in "1pP") or \
		(cmd in "0l" and prev_cmd in "0nN")
	# hard_edge는 wavedrom에서 표현하기 어려운 것이 들어있으면 true 아니면 false
	if cmd == "u":
		edge, flat = ("U", "u")      #high 점선
	elif cmd == "d":
		edge, flat = ("D", "d")      
	elif cmd == "H":
		edge, flat = ("r", "1")
	elif cmd == "L":
		edge, flat = ("f", "0")
	elif high:
		edge, flat = ("+", "1")
	else:
		edge, flat = ("-", "0")
	rendered = edge * hard_edge + flat * (width - hard_edge)		# rendered를 받아서 s로 한줄씩 받아오기
	for s in rendered:
		put(s)

def cmd_clk(cmd, prev_cmd, width, charwidth, data, put):		# pPnN처리
	shape = {
		"p": "+1-0",
		"P": "r1-0",
		"n": "-0+1",
		"N": "f0+1"
	}[cmd]
	if (cmd == "p" and prev_cmd in "hH") or (cmd == "n" and prev_cmd in "lL"):
		shape = shape[1] + shape[1:]
	for i in range(width // charwidth):
		put(shape[0])						# shape[0]에선 wavedrom에서 파형을 나타내는 문자갯수 파악(ex> p.......이면 r로 8개를 나타냄)
		for j in range(charwidth // 2 - 1):	
			put(shape[1])					# shape[1]에선 clk의 high에서의 "-"갯수를 1로 표현
		put(shape[2])						# shape[2]에선 clk의 high에서 low로 갈때 "-"가 나오게 
		for j in range(charwidth // 2 - 1):
			put(shape[3])					# shape[3]에선 clk의 low에서의 "-"갯수를 1로 표현

def cmd_bus(cmd, prev_cmd, width, charwidth, data, put):		# JSON에서 DATA를 하나씩 뽑아서 처리 <>안에
	assert(cmd in "=2345")
	if len(data) > 0:
		contents = data.pop(0)									# contents는 data에서 하나씩 pop을 하여 파형안에 넣어주기
	else:
		contents = ""
	space = width - 2											# space는 data형 갯수(ex> a,b,c,d이면 4개)
	contents = contents[:min(len(contents), space)]				# 파형에서 <>안에 들어갈 수 있는 문자열 길이제한
	contents = "{: ^{}}".format(contents, space)				
	put("<")
	for c in contents:
		put(c, raw_char=True)
		# for i in range(len(outs)):
		# 	outs[i] += c if i == len(outs) // 2 else " "
	put(">")

def cmd_separator(cmd, prev_cmd, width, charwidth, data, put):		# |이대로 받고 출력
	put("|")


def cmd_other(cmd, prev_cmd, width, charwidth, data, put):	# 문자로 받아진 것들을 판단 예를 들어 z 나 x 이런 것들
	for i in range(width):	
		put(cmd.lower())									# z나 x는 소대문자 구분없이 같게 그려지므로 소문자로 바꿔 사용해도 가능하여 사용

# Create callback for appending some wave state's graphics to an array of strings
def create_put(outs, graphics_map):
	def put(c, raw_char=False):				# width만큼 파형길이 만큼 출력(한자리씩)
		for i in range(len(outs)):
			if raw_char:
				outs[i] += c if i == len(outs) // 2 else " "
			else:
				outs[i] += graphics_map[c][i]
	return put					# put함수 반환

def render_signal(wave, data, charwidth, graphics_map):
	if not hasattr(render_signal, "handlers"):			#render_signal에 "handlers"의 속성이 존재하면 true or false로 반환
		render_signal.handlers = {}
		
		for c in "1hHu0lLd":
			render_signal.handlers[c] = cmd_10
		for c in "pPnN":
			render_signal.handlers[c] = cmd_clk
		for c in "=2345":
			render_signal.handlers[c] = cmd_bus
		for c in "xXzZ":
			render_signal.handlers[c] = cmd_other
		render_signal.handlers["|"] = cmd_separator
	assert(charwidth >=4 and charwidth % 2 == 0)

	outs = [""] * len(graphics_map[" "])
	put = create_put(outs, graphics_map)
	if type(data) is str:
		data = data.split()
	else:
		data = data[:]
	prev_cmd = "x"
	wstream = iter(wave)			# wstream은 wave를 가져온다.

	while True:
		cmd = next(wstream, None)		# cmd는 wstream을 반복으로 가져오면서 None이 될때까지 
		if cmd is None:				
			break
		if cmd == ".":
			cmd = prev_cmd
		if cmd not in render_signal.handlers:
			cmd = "x"
		width = charwidth
		# . refers to command *before* |, so terminate early and don't touch prev_cmd
		while cmd != "|":
			next_cmd = next(wstream, None)
			if next_cmd == ".":
				width += charwidth		#똑같은 곳에 찍으며 안되므로 길이를 charwidth만큼 증가시켜 그 다음위치에 출력하게 하려고 더해준다.
			else:
				wstream = itertools.chain([next_cmd], wstream)			
				break
		render_signal.handlers[cmd](cmd, prev_cmd, width, charwidth, data, put)
		if cmd != "|":
			prev_cmd = cmd

	return outs

def render_json(src, out, graphics, force_hscale=None):			#src 파일 읽기, out은 출력, render_json함수는 파일을 받고 파형출력(ex> 넓이,크기, 딜레이 등을 받아서 )
	# Currently we spend ~95% of our time in the JSON parser
	obj = json5.loads(src)					# src를 불러와서 obj에 저장
	jsonschema.Draft6Validator(wavejson_schema).validate(obj)			# jsonschema.validate가 json형식이 맞는지 확인
	# 예시 tall기준 첫번째 0이 키값 밑에 0이랑 같은 줄에 있는 것이 하나의 value값으로 들어감.
	# {'0': (' ', ' ', '─'), '+': ('┌', '│', '┘'), '1': ('─', ' ', ' '), '-': ('┐', '│', '└'), 
   	#  'r': ('┏', '┃', '┛'), 'f': ('┓', '┃', '┗'), 'x': ('x', 'x', 'x'), 'z': (' ', '─', ' '), 
   	#  '<': ('╱', ' ', '╲'), ' ': (' ', ' ', ' '), '>': ('╲', ' ', '╱'), '|': ('┆', '┆', '┆'),
   	#  'U': ('╭', '┆', ' '), 'u': ('┄', ' ', ' '), 'D': (' ', '┆', '╰'), 'd': (' ', ' ', '┄')}
	graphics_map = dict(zip(graphics[0], zip(*graphics[1:])))				 # graphics 0번째꺼를 key로 첫번째꺼부터 끝까지를 value로 해서 딕셔너리로 표현
	# Find longest signal name, and handle config
	max_name_len = 0
	for s in obj["signal"]:					# obj(json파일)에 signal이 있는지 확인
		if "name" in s:
			max_name_len = max(max_name_len, len(s["name"]))
	try:
		hscale = int(obj["config"]["hscale"] * 2 + 2)
	except KeyError:
		hscale = 6
	if force_hscale is not None:
		hscale = force_hscale * 2 + 2

	# Second pass: actually render
	for s in (obj["signal"] if "signal" in obj else []):
		if len(s) == 0:				# json파일안에서 signal일때 {}이면 공백처리
			print("")
			continue
		name = s["name"] if "name" in s else ""
		name_just = "{: <{}}: ".format(name, max_name_len)			# key값뒤에 콜론 정렬(왼쪽정렬 후 name값들 콜론 위치 ex) clk : 이런식으로)
		charwidth = int(s["period"] * hscale) if "period" in s else hscale		# 넓이 (period가 파형의 넓이 조절(period가 길어지면 파형이 옆으로 길어짐), 기본넓이: hscale)
		lead = int(s["phase"] * charwidth) if "phase" in s else 0				# phase 관점: -면 delay되어 파형이 나오고 + 면 앞에 그만큼 짤려서 나온다.
		lag = max(-lead, 0)
		lead = max(lead, 0)
		
		
		sig_lines = render_signal(								# render_signal 함수 호출 
			s["wave"] if "wave" in s else "",
			s["data"] if "data" in s else [], charwidth, graphics_map)
		for i, l in enumerate(sig_lines):
			if i == len(graphics_map[" "]) - 1:
				out.write(name_just)
			else:
				out.write(" " * len(name_just))
			out.write(" " * lag)
			out.write(l[lead:] + "\n")

def posint(x):
	_x = int(x)
	if _x <= 0:
		raise TypeError(x)
	return _x
def create_tb(src):	
	obj = json5.loads(src)
	jsonschema.Draft6Validator(wavejson_schema).validate(obj)
	print(obj)
if __name__ == "__main__":
	# Preserve newlines in docstring:
	parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter)
	parser.epilog = __doc__		#__doc__ 도움말을 가져오기 위해
	parser.add_argument("src", help="WaveJSON source file")		# waveJSON source file을 요구
	#parser.add_argmument("module_src", help="verilog module file")
	parser.add_argument("-w", "--watch", action="store_true",	# ,watch가 지정되면 watch에 관련된 것을 실행, action: 인자를 적으면 해당 인자에 true를 저장 
		help="Watch file, continuously update and redraw")
	parser.add_argument("-g", "--graphics", choices=["default", "tiny", "tall"], # 인자와 같이 주어지는 값의 범위를 제한하고 싶으면 choices= 옵션을 쓰면 됨.
		default="default", help="Use a different graphics tileset")
	parser.add_argument("--hscale", type=posint,
		help="Force hscale to a different value than specified in src config.")
	parser.add_argument("-v","--vcode", action = "store_true",	
		help="generate a testbench by verilog code")
	args = parser.parse_args()

	graphics = {
		"default": graphics_default,
		"tiny": graphics_tiny,
		"tall": graphics_tall
	}[args.graphics]

	if args.watch:							
		prev_src = None
		while True:
			ifile = open(args.src)
			src = ifile.read()
			ifile.close()
			if src != prev_src:
				print("\033[H\033[J") 			# VT100 clear command
				try:
					render_json(src, sys.stdout, graphics, force_hscale=args.hscale)		# sys.stdout은  표준출력 저장(백업)
				except Exception:
					traceback.print_exc(file=sys.stdout)
				print("\nWatching file " + args.src)
				print("Ctrl-C to exit")
				prev_src = src
				
			time.sleep(0.2)			# 0.2초 일시정지
	else:
		ifile = open(args.src)
		render_json(ifile.read(), sys.stdout, graphics, force_hscale=args.hscale)


	'''if args.vcode:
		if(create_tb(args.module_src, args.src)):
				print(f.read())
	else:
			vfile = open(args.module.src)
			create_tb(args.module_src, args.src)'''