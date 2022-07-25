module D_FF(d,q, clk, rst_n);
    output q;
    input d, clk, rst_n;
    reg q;

    always @(posedge clk or negedge rst_n)
        if (!rst_n)
            q<=1'b0;
        else 
            q<=d;

endmodule