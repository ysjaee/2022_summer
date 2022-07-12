module demux_always(demux_in,sel,demux_out_a,demux_out_b,demux_out_c,demux_out_d);
    input demux_in;
    input [1:0] sel;
    output reg demux_out_a;
    output reg demux_out_b;
    output reg demux_out_c;
    output reg demux_out_d;
    
    always @ (demux_in or sel) begin
        if (sel == 2'b00)
            demux_out_a = demux_in;
        else 
            demux_out_a = 1'b0;
        if (sel == 2'b01)
            demux_out_b = demux_in;
        else
            demux_out_b = 1'b0; 
        if (sel == 2'b10)
            demux_out_c = demux_in;
        else
            demux_out_c = 1'b0;
        if (sel == 2'b11)
            demux_out_d = demux_in;
        else
            demux_out_d = 1'b0;
    end
endmodule