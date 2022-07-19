module t_ff(q,t,clk,rst_n);
    input clk;
    input rst_n;
    input t;
    output q;
    wire d;
    d_ff df(.d(d),.clk(clk),.rst_n(rst_n),.q(q));
    
    assign d = t^q;
endmodule   