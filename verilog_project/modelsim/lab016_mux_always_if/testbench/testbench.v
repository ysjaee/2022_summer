module testbench();
    reg a;
    reg b;
    reg c;
    reg d;
    reg [1:0] sel;
    wire mux_out;

    mux m (a,b,c,d,sel,mux_out);

    initial begin
        a = 1'b0; b = 1'b1; c = 1'b1; d = 1'b0; sel =2'b00;
        #10 sel =2'b01;
        #10 sel =2'b10;
        #10 sel =2'b11;
        #10 $stop;
    end
endmodule
