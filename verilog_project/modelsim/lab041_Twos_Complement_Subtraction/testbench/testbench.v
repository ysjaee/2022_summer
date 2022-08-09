module testbench();
    reg [3:0]a;
    reg [3:0]b;
    reg cin;
    wire [3:0]cout;
    wire [3:0]s;

    Twos_Complement_Subtraction TCS(.a(a),.b(b),.cin(cin),.cout(cout),.s(s));
    initial begin
        cin = 1'b1; a = 4'b0001; b = 4'b0001;
        #5 cin = 1'b1; a = 4'b0001; b = 4'b0001;
        #5 cin = 1'b1; a = 4'b0011; b = 4'b0011;
        #5 cin = 1'b1; a = 4'b0111; b = 4'b0111;
        #5 cin = 1'b1; a = 4'b1001; b = 4'b0001;
        #5 cin = 1'b1; a = 4'b1111; b = 4'b0001;
        #5 cin = 1'b0; a = 4'b0001; b = 4'b0001;
        #5 cin = 1'b0; a = 4'b0111; b = 4'b0001;
        #40 $stop;
    end
endmodule