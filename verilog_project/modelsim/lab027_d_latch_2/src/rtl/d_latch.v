module d_latch(d,q,clk);
input d;
input clk;
output reg q;

always @ (clk)
    if (clk == 1'b0)
        q <= q;
    else if (clk == 1'b1)
        q <= d;
    else
        q <= 1'b0;
endmodule
