module d_latch(d_in,clk,q,qbar);
    input d_in;
    input clk;
    output reg q;
    output reg qbar;


    always @(*) begin
        if (clk == 1'b0) begin
            q = q; qbar = ~q;
        end
        else begin
            q = d_in; qbar = ~(d_in);
        end
    end
endmodule
