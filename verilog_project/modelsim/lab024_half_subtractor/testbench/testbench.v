module testbench();
    reg x;
    reg y;
    wire b;
    wire d;

    half_substractor hs(x,y,b,d);

    initial begin
        x = 1'b0; y = 1'b0;
        #10 x = 1'b0; y = 1'b1;
        #10 x = 1'b1; y = 1'b0;
        #10 x = 1'b1; y = 1'b1;
        #10 $stop;
    end
endmodule