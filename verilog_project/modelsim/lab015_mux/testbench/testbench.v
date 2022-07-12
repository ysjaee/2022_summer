module testbench();
    reg a;
    reg b;
    reg c;
    reg d;
    reg [1:0] sel;
    wire out;

    encoder e(a,b,c,d,sel,out);

    initial begin
        a =1'b0; b =1'b1; c =1'b1; d=1'b0; sel = 2'h0;
        #10 sel=2'h1;
        #10 sel=2'h2;
        #10 sel=2'h3;
        #10 $stop;
    end
endmodule