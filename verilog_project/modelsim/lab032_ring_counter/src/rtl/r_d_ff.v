module r_d_ff(q,d, clk, rst_n);
    input d;
    input clk;
    input rst_n;
    output q;
    reg q;

    always @(posedge clk or negedge rst_n)
        if (!rst_n)
            q<=1'b1;
        else
            q<=d;

endmodule