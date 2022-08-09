module Twos_Complement_Subtraction(a,b,cin,cout,s);
    input [3:0]a;           // if c in == 1'b1 >> twos complement subtrction
    input [3:0]b;
    input cin;
    output cout;
    output [3:0]s;
    wire c1;
    wire c2;
    wire c3;
    wire [3:0]b2;
    assign b2 = (cin == 1'b1)?~b:b;

    full_adder fa0(.a(a[0]),.b(b2[0]),.cin(cin),.cout(c1),.s(s[0]));
    full_adder fa1(.a(a[1]),.b(b2[1]),.cin(c1),.cout(c2),.s(s[1]));
    full_adder fa2(.a(a[2]),.b(b2[2]),.cin(c2),.cout(c3),.s(s[2]));
    full_adder fa3(.a(a[3]),.b(b2[3]),.cin(c3),.cout(cout),.s(s[3]));
endmodule
