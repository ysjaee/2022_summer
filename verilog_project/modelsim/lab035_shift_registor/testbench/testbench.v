module testbench();
    
  reg d;
  reg rst_n;
  reg clk;
  reg sl;
  reg sr;
  wire [3:0]q;

  shift_register shr(d,q,sl,sr,clk,rst_n);
    always #5 clk = ~clk;
    initial begin
        rst_n = 1'b0; sr = 1'b0; sl = 1'b0; clk = 1'b0;
        #3 rst_n = 1'b1;
        #7 sr =1'b1; sl = 1'b0;
        #30 sr = 1'b0; sl = 1'b1;
        #60 $stop;
    end
endmodule