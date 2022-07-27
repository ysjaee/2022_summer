module D_FF(d,q, clk, rst_n);
    output reg [3:0]q;
    input [3:0]d, clk, rst_n;

    always @(posedge clk or negedge rst_n)
        if (rst_n)
            q<=4'h0;
        else 
            q<=d;

endmodule