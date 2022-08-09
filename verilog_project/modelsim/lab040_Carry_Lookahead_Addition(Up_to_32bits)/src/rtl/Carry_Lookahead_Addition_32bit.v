module Carry_Lookahead_Addition_32bit(a_in,b_in,c_in,cout,out_s);
    input [31:0]a_in;
    input [31:0]b_in;
    input c_in;
    output [31:0]out_s;
    output cout;
    wire c16;


    Carry_Lookahead_Addition_16bit CL1(.a_in(a_in[15:0]),.b_in(b_in[15:0]),.c_in(c_in),.cout(c16),.out_s(out_s[15:0]));
    Carry_Lookahead_Addition_16bit CL2(.a_in(a_in[31:16]),.b_in(b_in[31:16]),.c_in(c16),.cout(cout),.out_s(out_s[31:16]));
endmodule




