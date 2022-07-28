module testbench();
    reg clk;
    reg rst_n;
    reg in;
    wire out;

    Moore_machine Mm(clk, rst_n, in, out);

    always #5 clk = ~clk;
    initial begin
      clk = 1'b0; rst_n = 1'b0; in =1'b0;
      #3 rst_n =1'b1;
      #5 in =1'b1;
      #10 in = 1'b0;
      #10 in = 1'b1;
      #10 in = 1'b1;
      #40 $stop;
    end
endmodule