module testbench();

    reg d;
    reg clk;
    reg reset_n;
    wire q;
    
    d_ff df(q,d, clk, reset_n);
    
    always #5 clk = ~clk;

    initial begin
        clk = 1'b0; reset_n = 1'b0; d = 1'b0;
        #7 reset_n = 1'b1; 
        #10 d =1'b1;
        #30 d =1'b0;
        #40 $stop;
    end
endmodule