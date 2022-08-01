module Ripple_carry_addition(x,y,ci,co,res);
    input [31:0]x;
    input [31:0]y;
    input ci;
    output co;
    output [31:0]res;
    wire ci1;

    Ripple_carry_adder_16bit Rc16_0(.in_a(x[15:0]),.in_b(y[15:0]),.in_c(ci),.out_c(ci1),.sum0(res[15:0]));
    Ripple_carry_adder_16bit Rc16_1(.in_a(x[31:16]),.in_b(y[31:16]),.in_c(ci1),.out_c(co),.sum0(res[31:16]));
endmodule