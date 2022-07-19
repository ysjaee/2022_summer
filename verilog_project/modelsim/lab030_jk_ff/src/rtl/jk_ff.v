module jk_ff(j,k,clk,rst_n,q);
    input j;
    input k;
    input clk;
    input rst_n;
    output reg q;

    always @ (posedge clk or negedge rst_n)
        if (!rst_n)
            q <= 1'b0;
        else if (j == 1'b0 && k == 1'b0) 
            q <= q; 
        else if (j == 1'b1 && k == 1'b0)
            q <= 1'b1;
        else if (j == 1'b0 && k == 1'b1)
            q<= 1'b0;
        else if (j == 1'b1 && k == 1'b1)
            q <= (~q);
        else
            q <= q;
endmodule