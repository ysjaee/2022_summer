module encoder (in, out,valid);
input [7:0] in;
output reg [2:0] out;
output reg valid;
always @ (in) begin
    if (in == 8'b1000_0000) begin
        out = 3'b000; valid = 1'b1;
    end
    else if (in == 8'b0100_0000) begin
        out = 3'b001; valid = 1'b1;
    end
    else if (in == 8'b0010_0000) begin
        out =3'b010; valid = 1'b1;
    end

    else if (in == 8'b0001_0000) begin
        out = 3'b011; valid = 1'b1;
    end
    else if (in == 8'b0000_1000) begin
        out = 3'b100; valid = 1'b1;
    end
    else if (in == 8'b0000_0100) begin
        out = 3'b101; valid = 1'b1;
    end
    else if (in == 8'b0000_0010) begin
        out = 3'b110; valid = 1'b1;
    end
    else if (in == 8'b0000_0001) begin
        out = 3'b111; valid = 1'b1;
    end
    else begin
        out = 3'b000; valid = 1'b0;
    end
end
endmodule
        

