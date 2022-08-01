module Ripple_carry_adder_4bit(a,b,c_in,cout,s);
    input [3:0]a;
    input [3:0]b;
    input c_in;
    output cout;
    output [3:0]s;
    wire c1;
    wire c2;
    wire c3;
    full_adder fa0(.a(a[0]),.b(b[0]),.cin(c_in),.cout(c1),.s(s[0]));
    full_adder fa1(.a(a[1]),.b(b[1]),.cin(c1),.cout(c2),.s(s[1]));
    full_adder fa2(.a(a[2]),.b(b[2]),.cin(c2),.cout(c3),.s(s[2]));
    full_adder fa3(.a(a[3]),.b(b[3]),.cin(c3),.cout(cout),.s(s[3]));
endmodule