module  reg clk;
    reg rst_n;
    reg in;
    wire out;


    Mealy_machine Mm(in,out,clk,rst_n);

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

/* 
    `timescale 1ns/10ps
`define T_CLK 10

reg clk, rst_n;
initial clk = 1'b1;
always #(`T_CLK/2) clk = ~clk;

initial begin
	rst_n = 1'b0;
	#(`T_CLK*0.9) rst_n = 1'b1;
end

reg in;

initial begin
	in = 1'b0;
	#(`T_CLK*2.1) in = 1'b0;
	#(`T_CLK)     in = 1'b0;
	#(`T_CLK)     in = 1'b1;
	#(`T_CLK)     in = 1'b1;
	#(`T_CLK)     in = 1'b0;
	#(`T_CLK)     in = 1'b0;
	#(`T_CLK)     in = 1'b1;
#(`T_CLK)     in = 1'b0;
	#(`T_CLK)     in = 1'b1;
	#(`T_CLK)     in = 1'b1;
	#(`T_CLK)     in = 1'b1;
	#(`T_CLK)     in = 1'b0;
	#(`T_CLK*3)   $stop;
end
 Mealy_machine Mm(in,out,clk,rst_n);
*/