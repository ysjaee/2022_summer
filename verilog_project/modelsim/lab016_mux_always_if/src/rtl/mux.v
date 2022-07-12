module mux(a,b,c,d,sel,mux_out);
    input a;
    input b;
    input c;
    input d;
    input [1:0] sel;
    output reg mux_out;

    always @(a or b or c or d or sel) begin
        if (sel ==2'b00)
            mux_out = a;
        else if (sel ==2'b01)
            mux_out = b;
        else if (sel ==2'b10)
            mux_out = c;
        else
            mux_out = d;
    end
endmodule