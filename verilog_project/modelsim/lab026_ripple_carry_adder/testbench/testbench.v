module testbench();
    reg [3:0]a;
    reg [3:0]b;
    reg c_in;
    wire c_out;
    wire [3:0]sum;

    ripple_carry_adder rca(
        .a(a),
        .b(b),
        .c_in(c_in),
        .c_out(c_out)
        ,.sum(sum)
        );
    
    initial begin
        a = 4'h0; b = 4'h0; c_in =1'b0;
        #10 a = 4'h0; b = 4'h0; c_in =1'b1;
        #10 a = 4'h2; b = 4'h2; c_in =1'b0;
        #10 a = 4'h2; b = 4'h2; c_in =1'b1;
        #10 a = 4'h5; b = 4'h5; c_in =1'b0;
        #10 a = 4'h5; b = 4'h5; c_in =1'b1;
        #10 a = 4'h8; b = 4'h8; c_in =1'b0;
        #10 a = 4'h8; b = 4'h8; c_in =1'b1;
        #10 a = 4'hc; b = 4'hc; c_in =1'b0;
        #10 a = 4'hc; b = 4'hc; c_in =1'b1;
        #10 a = 4'hf; b = 4'hf; c_in =1'b0;
        #10 a = 4'hf; b = 4'hf; c_in =1'b1;
        #10 $stop;
    end
endmodule
