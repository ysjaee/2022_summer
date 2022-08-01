module Ripple_carry_adder_16bit(in_a,in_b,in_c,out_c,sum0);
    input [15:0]in_a;
    input [15:0]in_b;
    input in_c;
    output out_c;
    output [15:0]sum0;
    wire in_c1;
    wire in_c2;
    wire in_c3;

    Ripple_carry_adder_4bit R4_0(.a(in_a[3:0]),.b(in_b[3:0]),.c_in(in_c),.cout(in_c1),.s(sum0[3:0]));
    Ripple_carry_adder_4bit R4_1(.a(in_a[7:4]),.b(in_b[7:4]),.c_in(in_c1),.cout(in_c2),.s(sum0[7:4]));
    Ripple_carry_adder_4bit R4_2(.a(in_a[11:8]),.b(in_b[11:8]),.c_in(in_c2),.cout(in_c3),.s(sum0[11:8]));
    Ripple_carry_adder_4bit R4_3(.a(in_a[15:12]),.b(in_b[15:12]),.c_in(in_c3),.cout(out_c),.s(sum0[15:12]));
endmodule