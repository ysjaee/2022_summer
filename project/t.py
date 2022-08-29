import sys
with open ("not_gate.v",'r',encoding = 'utf-8') as fp:
	module = fp.readlines()		# vc == v.code
	for vl in module:
		vl = vl.strip()
		vl = vl.replace("input", "reg")
		vl = vl.replace("output", "wire")
		if vl.find("assign") != -1:
			vl=""







