module demux_case(in, sel, a,b,c,d);
    input in;
    input [1:0]sel;
    output reg a;
    output reg b;
    output reg c;
    output reg d;

always @(in, sel) begin
    case (sel) 
    2'b00 : begin 
        a = in;
        b = 1'b0; 
        c = 1'b0; 
        d = 1'b0; 
     end
    2'b01 : begin
        a = 1'b0;
        b = in; 
        c = 1'b0; 
        d = 1'b0;
    end
    2'b10 : begin
        a = 1'b0;
        b = 1'b0; 
        c = in; 
        d = 1'b0;
    end 
    2'b11 : begin
        a = 1'b0;
        b = 1'b0; 
        c = 1'b0; 
        d = in;
    end
    default : begin
        a = 1'b0;
        b = 1'b0;
        c = 1'b0;
        d = 1'b0;
    end
endcase
end
    
endmodule
    