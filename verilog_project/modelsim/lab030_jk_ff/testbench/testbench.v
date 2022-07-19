module testbench();
    reg clk;
    reg rst_n;
    reg j;
    reg k;
    wire q;

    
    jk_ff jkf(j,k,clk,rst_n,q,qbar);


    always #5 clk = ~clk;

    initial begin
        clk = 1'b0; rst_n =1'b0;
        #7 rst_n = 1'b1;
    end

    initial begin
        j = 1'b0; k = 1'b0;
        #20 j = 1'b1; k = 1'b0;
        #20 j = 1'b0; k = 1'b1;
        #20 j = 1'b1; k = 1'b1;
        #40 $stop;
    end
endmodule