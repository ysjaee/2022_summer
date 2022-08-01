module Carry_Lookahead_Addition_4bit(a,b,c,s)
    input [3:0]a;
    input [3:0]b;
    input c_in;
    output [3:0]p;
    output cout;
    wire[3:0]p;
    half_adder ha0(.a(a[0]),.b(b[0]),.c(),.s(p[0]));
    half_adder ha1(.a(a[1]),.b(b[1]),.c(),.s(p[1]));
    half_adder ha2(.a(a[2]),.b(b[2]),.c(),.s(p[2]));
    half_adder ha3(.a(a[3]),.b(b[3]),.c(),.s(p[3]));    

