module t_ff(t,q,clk,rst_n);
input t;
input clk;
input rst_n;
output reg q;

always @ (posedge clk or negedge rst_n)
    if (!rst_n)
        q <= 1'b0;
    else if (t == 1'b0)
        q <= q;
    else if (t == 1'b1)
        q <= ~q;
    else
        q <= q;
endmodule