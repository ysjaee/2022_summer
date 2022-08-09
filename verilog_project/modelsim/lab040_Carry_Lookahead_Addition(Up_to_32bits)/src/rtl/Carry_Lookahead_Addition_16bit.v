module Carry_Lookahead_Addition_16bit(a_in,b_in,c_in,cout,out_s);
    input [15:0]a_in;
    input [15:0]b_in;
    input c_in;
    output [15:0]out_s;
    output cout;
    wire c4;
    wire c8;
    wire c12;

    Carry_Lookahead_Addition_4bit CLA0(.a(a_in[3:0]),.b(b_in[3:0]),.c_in(c_in),.cout(c4),.s(out_s[3:0]));
    Carry_Lookahead_Addition_4bit CLA1(.a(a_in[7:4]),.b(b_in[7:4]),.c_in(c4),.cout(c8),.s(out_s[7:4]));
    Carry_Lookahead_Addition_4bit CLA2(.a(a_in[11:8]),.b(b_in[11:8]),.c_in(c8),.cout(c12),.s(out_s[11:8]));
    Carry_Lookahead_Addition_4bit CLA3(.a(a_in[15:12]),.b(b_in[15:12]),.c_in(c12),.cout(cout),.s(out_s[15:12])); 
endmodule