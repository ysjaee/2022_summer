module testbench();
    reg d_in;
    reg clk;
    wire q;
    wire qbar;

    d_latch dl(d_in,clk,q,qbar);

    initial begin
        clk = 1'b0; d_in = 1'b0;
        #10 clk = 1'b1; d_in = 1'b0;
        #10 clk = 1'b0; d_in = 1'b1;
        #10 clk = 1'b1; d_in = 1'b1;
        #10 $stop;
    end
endmodule