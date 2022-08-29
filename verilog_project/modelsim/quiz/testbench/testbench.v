module testbench();
    reg clk;
    reg rst_n;
    wire in0, in1;
    wire out;

    moore mr(.clk(clk),.rst_n(rst_n),.in0(in0),.in1(in1),.out(out));
    always #5 clk= ~clk;
    initial begin
        clk=1'b0; rst_n = 1'b0;
        #5 rst_n = 1'b1;
        #40 $stop;
    end
endmodule