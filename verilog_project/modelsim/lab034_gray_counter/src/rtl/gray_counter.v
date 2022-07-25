module gray_counter(d,q, clk, rst_n);
    input d;
    input clk;
    input rst_n;
    output [2:0]q;
    wire d1;
    wire d2;
    wire d3;
    assign d1 = (q[2] & q[0]) | (q[1] & (~q[0]));
    assign d2 = ((~q[2]) & q[0]) | (q[1] & (~q[0]));
    assign d3 = ((~q[2]) & (~q[1])) | (q[2] & q[1]);
    D_FF DF1(.d(d1),.q(q[2]), .clk(clk), .rst_n(rst_n));
    D_FF DF2(.d(d2),.q(q[1]), .clk(clk), .rst_n(rst_n));
    D_FF DF3(.d(d3),.q(q[0]), .clk(clk), .rst_n(rst_n));
endmodule
