module testbench();
    reg [2:0]in;
    wire odd;
    wire even;

    parity p(in,odd,even);
    
    initial begin
        in = 3'b000;
        #10 in = 3'b001;
        #10 in = 3'b010;
        #10 in = 3'b011;
        #10 in = 3'b100;
        #10 in = 3'b101;
        #10 in = 3'b110;
        #10 in = 3'b111;
        #10 $stop;
    end
endmodule