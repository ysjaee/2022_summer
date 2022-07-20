module testbench();
reg t;
reg clk;
reg rst_n;
wire [3:0]q;

binary_counter bc(t,q,clk,rst_n);

always # 5 clk = ~clk;

initial begin
    clk = 1'b0; rst_n =1'b0; t=1'b0;
    #7 rst_n = 1'b1;
    #5 t=1'b1;
    #100 $stop;
end
endmodule

