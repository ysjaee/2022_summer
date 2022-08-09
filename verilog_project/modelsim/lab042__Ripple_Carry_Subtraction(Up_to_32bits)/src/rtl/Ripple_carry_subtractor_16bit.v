module Ripple_carry_subtraction_16bit(a,b,cin,cout,s);
    input [15:0]a;           
    input [15:0]b;
    input cin;
    output cout;
    output [15:0]s;
    wire c1;
    wire c2;
    wire c3;

    Ripple_carry_subtraction_4bit Rcs0(.a(a[3:0]),.b(b[3:0]),.cin(cin),.cout(c1),.s(s[3:0]));
    Ripple_carry_subtraction_4bit Rcs1(.a(a[7:4]),.b(b[7:4]),.cin(c1),.cout(c2),.s(s[7:4]));
    Ripple_carry_subtraction_4bit Rcs2(.a(a[11:8]),.b(b[11:8]),.cin(c2),.cout(c3),.s(s[11:8]));
    Ripple_carry_subtraction_4bit Rcs3(.a(a[15:12]),.b(b[15:12]),.cin(c3),.cout(cout),.s(s[15:12]));
endmodule
