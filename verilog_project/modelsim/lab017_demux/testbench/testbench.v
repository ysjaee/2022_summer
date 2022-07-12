module testbench();
    reg demux_in;
    reg [7:0] sel;
    wire demux_out_a;
    wire demux_out_b;
    wire demux_out_c;
    wire demux_out_d;
    wire demux_out_e;
    wire demux_out_f;
    wire demux_out_g;
    wire demux_out_h;

    demux d(demux_in,sel,demux_out_a,demux_out_b,demux_out_c,demux_out_d,demux_out_e,demux_out_f,demux_out_g,demux_out_h);

    initial begin
        demux_in = 1'b1; sel = 3'h0;
        #10 sel = 3'h1;
        #10 sel = 3'h2;
        #10 sel = 3'h3;
        #10 sel = 3'h4;
        #10 sel = 3'h5;
        #10 sel = 3'h6;
        #10 sel = 3'h7;
        #10 $stop;
    end
endmodule