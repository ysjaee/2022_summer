module testbench();

    reg t;
    reg clk;
    reg rst_n;
    wire q;

    t_ff tf(t,q,clk,rst_n);
    
    always #5 clk = ~clk;

    initial begin
        clk = 1'b0; rst_n =1'b0;
        #7 rst_n = 1'b1;
    end

    initial begin
        t = 1'b0;
        #20 t =1'b1;
        #20 t =1'b0;
        #40 $stop;
    end
endmodule