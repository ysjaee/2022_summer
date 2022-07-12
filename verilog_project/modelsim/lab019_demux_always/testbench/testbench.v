module testbench();
    reg demux_in;
    reg [1:0] sel;
    wire demux_out_a;
    wire demux_out_b;
    wire demux_out_c;
    wire demux_out_d;

    demux_always da(demux_in,sel,demux_out_a,demux_out_b,demux_out_c,demux_out_d);

    initial begin
        sel = 2'b00; demux_in = 1'b1;
        # 10 sel = 2'b01;
        # 10 sel = 2'b10;
        # 10 sel = 2'b11;
        # 10 $stop;
    end
endmodule