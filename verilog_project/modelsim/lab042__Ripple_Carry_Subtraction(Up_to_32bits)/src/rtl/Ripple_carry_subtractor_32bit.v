module Ripple_carry_subtraction_32bit(a,b,cin,cout,s);
    input [31:0]a;           
    input [31:0]b;
    input cin;
    output cout;
    output [31:0]s;
    wire c1;
    wire [31:0]b2;
    assign b2 = ~b;

    Ripple_carry_subtraction_16bit Rs1(.a(a[15:0]),.b(b2[15:0]),.cin(cin),.cout(c1),.s(s[15:0]));
    Ripple_carry_subtraction_16bit Rs2(.a(a[31:16]),.b(b2[31:16]),.cin(c1),.cout(cout),.s(s[31:16]));

endmodule
