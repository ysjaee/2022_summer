module johnson_counter(q,clk,rst_n);
input clk;
input rst_n;
output [3:0]q;

D_FF DF0(.d(q[1]),.q(q[0]), .clk(clk), .rst_n(rst_n));
D_FF DF1(.d(q[2]),.q(q[1]), .clk(clk), .rst_n(rst_n));
D_FF DF2(.d(q[3]),.q(q[2]), .clk(clk), .rst_n(rst_n));
D_FF DF3(.d(~q[0]),.q(q[3]), .clk(clk), .rst_n(rst_n));
endmodule