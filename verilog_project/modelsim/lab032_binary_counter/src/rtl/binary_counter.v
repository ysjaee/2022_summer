module binary_counter(t,q,clk,rst_n);
    input t;
    input clk, rst_n;
    output [3:0]q;
    wire t2;
    wire t3;
assign t2 = q[0] & q[1];
assign t3 = q[0] & q[1] & q[2];
t_ff tf0(.t(t),.clk(clk),.rst_n(rst_n),.q(q[0]));
t_ff tf1(.t(q[0]),.clk(clk),.rst_n(rst_n),.q(q[1]));
t_ff tf2(.t(t2),.clk(clk),.rst_n(rst_n),.q(q[2]));
t_ff tf3(.t(t3),.clk(clk),.rst_n(rst_n),.q(q[3]));
endmodule
