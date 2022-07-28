module Mealy_machine(in,out,clk,rst_n);
    input clk;
    input rst_n;
    input in;
    output out;
    reg out;

    parameter s0 =2'h0;
    parameter s1 =2'h1;

    reg c_state;
    reg n_state;
    always @ (posedge clk or negedge rst_n)
        if (!rst_n)
            c_state <= s0;
        else
            c_state <= n_state;

    always @ (c_state or in)
        case(c_state)
            s0: begin
                n_state = (in==1'b1)?s1:c_state;
                out = 1'b0;
            end
            s1: begin
                n_state = (in==1'b0) ? s0:c_state;
                out = (in==1'b1)? 1'b1:1'b0;
            end
            default: begin
                n_state = s0;
                out = 1'b0;
            end
        endcase
endmodule

