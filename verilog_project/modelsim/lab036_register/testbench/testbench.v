module testbench();
reg [3:0]x;
reg Ld;
reg Rd;
wire [3:0]q;
wire [3:0]y;

    register rg(x, Ld, Rd, q, y);

initial begin
    Ld = 1'b0; Rd = 1'b0; x =4'b0000;
    #3 x = 4'b0101;
    #5 Ld = 1'b1;
    #12 Rd = 1'b1; x = 4'b0101;
    #40 $stop;
end
endmodule 