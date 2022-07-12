module testbench();
    reg a;
    reg b;
    reg c;
    reg d;
    reg [1:0]sel;
    wire out;

    mux_case mc(.a(a),.b(b),.c(c),.d(d),.sel(sel),.out(out));

    initial begin
        sel =2'b00; a=1'b0; b = 1'b1; c = 1'b1; d =1'b0;
        # 10 sel =2'b01;
        # 10 sel =2'b10;
        # 10 sel =2'b11;
        # 10 $stop;
    end
endmodule

        
        