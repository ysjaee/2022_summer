module testbench();
    reg a;
    reg b;
    wire out;

    and_gate ag(a,b,out);
    //<MODULE> <MODULE_INSTANCE> (TERMINAL_lIST);
    
    initial begin
        a = 1'b0; b = 1'b0;
        #10; a = 1'b0; b = 1'b1;
        #10; a = 1'b1; b = 1'b0;
        #10; a = 1'b1; b = 1'b1;
        #10; $stop;
    end
endmodule
x