module testbench();
    reg a;
    reg b;
    wire c;
    wire s;

    half_adder ha(a,b,c,s);
    
    initial begin
        a = 1'b0; b = 1'b0;
        # 10 a = 1'b0; b = 1'b1;
        # 10 a = 1'b1; b = 1'b0;
        # 10 a = 1'b1; b = 1'b1;
        # 10 $stop;
    end
endmodule