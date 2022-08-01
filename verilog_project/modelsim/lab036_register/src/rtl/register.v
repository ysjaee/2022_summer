module register(x, Ld, Rd, q, y);
input [3:0]x;
input Ld;
input Rd;
output [3:0]q;
output [3:0]y;
reg [3:0]y;
    D_FF DF0(.d(x),.q(q),.clk(Ld),.rst_n(Rd));
always @ (Rd)
    if (Rd == 1'b1)
        y <= q;
    else
        y <= 4'b0000;
endmodule  