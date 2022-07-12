module demux(demux_in,sel,demux_out_a,demux_out_b,demux_out_c,demux_out_d,demux_out_e,demux_out_f,demux_out_g,demux_out_h);
    input demux_in;
    input [2:0] sel;
    output demux_out_a;
    output demux_out_b;
    output demux_out_c;
    output demux_out_d;
    output demux_out_e;
    output demux_out_f;
    output demux_out_g;
    output demux_out_h;

    assign demux_out_a = (sel==3'h0)? demux_in: 1'b0;
    assign demux_out_b = (sel==3'h1)? demux_in: 1'b0;
    assign demux_out_c = (sel==3'h2)? demux_in: 1'b0;
    assign demux_out_d = (sel==3'h3)? demux_in: 1'b0;
    assign demux_out_e = (sel==3'h4)? demux_in: 1'b0;
    assign demux_out_f = (sel==3'h5)? demux_in: 1'b0;
    assign demux_out_g = (sel==3'h6)? demux_in: 1'b0;
    assign demux_out_h = (sel==3'h7)? demux_in: 1'b0;
endmodule