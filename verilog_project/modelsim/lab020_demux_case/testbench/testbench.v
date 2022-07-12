module testbench();
    reg in;
    reg [1:0] sel;
    wire a;
    wire b;
    wire c;
    wire d;

    demux_case dc (in,sel,a,b,c,d);

    initial begin
        sel = 2'b00; in = 1'b1;
        #10 sel = 2'b01; 
        #10 sel = 2'b10;
        #10 sel = 2'b11;
        #10 $stop;
    end
endmodule
    
