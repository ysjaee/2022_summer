module testbench();
    reg d;
    reg clk;
    reg rst_n;
    wire [2:0]q;

    gray_counter gc(d,q, clk, rst_n);

    always #5 clk = ~clk;
    initial begin
        rst_n = 1'b0; clk =1'b0;
        #3 rst_n = 1'b1;
        #40 $stop;
    end
endmodule