module Carry_Lookahead_Addition_4bit(a,b,c_in,cout,s);
    input [3:0]a;
    input [3:0]b;
    input c_in;
    output cout;
    output [3:0]s;
    wire [3:0]c;
    wire [3:0]p;
    wire [3:0]g;
    
    half_adder ha0(.a(a[0]),.b(b[0]),.c(g[0]),.s(p[0]));
    half_adder ha1(.a(a[1]),.b(b[1]),.c(g[1]),.s(p[1]));
    half_adder ha2(.a(a[2]),.b(b[2]),.c(g[2]),.s(p[2]));
    half_adder ha3(.a(a[3]),.b(b[3]),.c(g[3]),.s(p[3]));    
    assign c[0] = c_in;
    assign c[1] = g[0] | (c[0] & p[0]);
    assign c[2] = g[1] | (c[1] & p[1]);
    assign c[3] = g[2] | (c[2] & p[2]);
    assign cout = g[3] | (c[3] & p[3]);
    assign s = c ^ a ^ b ;
endmodule