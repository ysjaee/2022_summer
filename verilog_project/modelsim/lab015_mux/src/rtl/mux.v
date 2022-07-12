module encoder (a,b,c,d,sel,out);
    input a;
    input b;
    input c;
    input d;
    input [1:0] sel;
    output out;

    assign out = (sel==2'h0)? a:
                 (sel==2'h1)? b:
                 (sel==2'h2)? c:
                 d;
endmodule
