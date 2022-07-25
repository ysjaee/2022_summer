module shift_register(d,q,sl,sr,clk,rst_n);
  input d;
  input rst_n;
  input clk;
  input sl;
  input sr;
  output [3:0]q;

  reg [3:0]dff_in;

  always @ (*)
  if (sr == 1'b0 & sl == 1'b1) begin
    dff_in[0] = q[3];
    dff_in[1] = q[0];
    dff_in[2] = q[1];
    dff_in[3] = q[2];
  end
  else if (sr == 1'b1 & sl == 1'b0) begin
    dff_in[0] = q[1];
    dff_in[1] = q[2];
    dff_in[2] = q[3];
    dff_in[3] = q[0];
  end
  else
    dff_in = q;

  D_FF DF0(.d(dff_in[0]),.q(q[0]), .clk(clk), .rst_n(rst_n));
  D_FF DF1(.d(dff_in[1]),.q(q[1]), .clk(clk), .rst_n(rst_n));
  rD_FF DF2(.d(dff_in[2]),.q(q[2]), .clk(clk), .rst_n(rst_n));
  rD_FF DF3(.d(dff_in[3]),.q(q[3]), .clk(clk), .rst_n(rst_n));
endmodule