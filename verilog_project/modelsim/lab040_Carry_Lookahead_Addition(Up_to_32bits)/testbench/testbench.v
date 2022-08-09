module testbench();
    reg [31:0]a_in;
    reg [31:0]b_in;
    reg c_in;
    wire [31:0]out_s;
    wire cout;

    Carry_Lookahead_Addition_32bit CLA32(.a_in(a_in),.b_in(b_in),.c_in(c_in),.cout(cout),.out_s(out_s));

    initial begin
        c_in = 1'b0; a_in = 32'h00000000; b_in = 32'h00000000;
        #5 c_in = 1'b0; a_in = 32'h00000001; b_in = 32'h00000001;
        #5 c_in = 1'b0; a_in = 32'h00000010; b_in = 32'h00000010;
        #5 c_in = 1'b0; a_in = 32'h00000100; b_in = 32'h00000100;
        #5 c_in = 1'b0; a_in = 32'h00001000; b_in = 32'h00001000;
        #5 c_in = 1'b0; a_in = 32'h00010000; b_in = 32'h00010000;
        #5 c_in = 1'b1; a_in = 32'h00100001; b_in = 32'h00100001;
        #5 c_in = 1'b1; a_in = 32'h01000001; b_in = 32'h01000001;
        #5 c_in = 1'b1; a_in = 32'h11000001; b_in = 32'h11000001;
        #5 c_in = 1'b0; a_in = 32'h11110001; b_in = 32'h11110001;
        #40 $stop;
    end
endmodule