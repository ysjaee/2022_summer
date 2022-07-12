module parity(in,odd,even);
    input [2:0]in;
    output reg odd;
    output reg even;

    always @ (in) begin
        if (in ==3'b000) begin
            odd =1'b1; even = 1'b0;
        end
        else if (in == 3'b001) begin
            odd = 1'b0; even = 1'b1;
        end
        else if (in == 3'b010) begin
            odd = 1'b0; even = 1'b1;
        end
        else if (in == 3'b011) begin
            odd = 1'b1; even = 1'b0;
        end
        else if (in == 3'b100) begin
            odd = 1'b0; even = 1'b1;
        end
        else if (in == 3'b101) begin
            odd = 1'b1; even = 1'b0;
        end
        else if (in == 3'b110) begin
            odd = 1'b1; even = 1'b0;
        end
        else if (in == 3'b111) begin
            odd = 1'b0; even = 1'b1;
        end
        else begin
            odd = 1'b0; even = 1'b0;
        end
    end
endmodule