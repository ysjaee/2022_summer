module testbench();
    reg [31:0]a;
    reg [31:0]b;
    reg cin;
    wire cout;
    wire [31:0]s;

    Ripple_carry_subtraction_32bit Rcs(.a(a),.b(b),.cin(cin),.cout(cout),.s(s));
    initial begin
        cin = 1'b1; a = 32'h00000001; b = 32'h00000001;
        #5 cin = 1'b1; a = 32'h00000011; b = 32'h00000001;
        #5 cin = 1'b1; a = 32'h00000111; b = 32'h00000011;
        #5 cin = 1'b1; a = 32'h11111111; b = 32'h10001001;
        #5 cin = 1'b1; a = 32'h11111111; b = 32'h00001111;
        #5 cin = 1'b1; a = 32'h11110001; b = 32'h00001111;
        #5 cin = 1'b1; a = 32'h10101010; b = 32'h01010101;
        #5 cin = 1'b1; a = 32'h10001111; b = 32'h00001111;
        #40 $stop;
    end
endmodule