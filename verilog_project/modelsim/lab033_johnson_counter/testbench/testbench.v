module testbench();
reg clk;
reg rst_n;
wire [3:0] q;

johnson_counter jc(q,clk,rst_n);

always #5 clk = ~clk;
initial begin
    rst_n = 1'b0; clk = 1'b0;
    #3 rst_n = 1'b1;
    #60 $stop;
end
endmodule