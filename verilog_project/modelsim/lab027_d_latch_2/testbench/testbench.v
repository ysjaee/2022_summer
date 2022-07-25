module testbench();
reg d;
reg clk;
wire q;

d_latch dl(d,q,clk);

always #5 clk = ~clk;

always #7 d=~d;
initial begin
    d = 1'b0; clk = 1'b0;
    #40 $stop;
end
endmodule