module testbench();
    reg a;
    reg b;
    reg c_in;
    wire c_out;
    wire sum;

    full_adder fa(
        .a(a),
        .b(b),
        .c_in(c_in),
        .sum(sum),
        .c_out(c_out)
        );

    initial begin
        a = 1'b0; b = 1'b0; c_in = 0;
        #10 a = 1'b0; b = 1'b0; c_in = 1;
        # 10 a = 1'b0; b = 1'b1; c_in = 0;
        # 10 a = 1'b0; b = 1'b1; c_in = 1;
        # 10 a = 1'b1; b = 1'b0; c_in = 0;
        # 10 a = 1'b1; b = 1'b0; c_in = 1;
        # 10 a = 1'b1; b = 1'b1; c_in = 0;
        # 10 a = 1'b1; b = 1'b1; c_in = 1;
        # 10 $stop;
    end
endmodule