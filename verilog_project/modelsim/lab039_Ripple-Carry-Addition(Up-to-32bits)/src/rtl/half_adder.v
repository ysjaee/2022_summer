module half_adder(a,b,c,s);
    input a;
    input b;
    output c;
    output s;

    assign c = a & b;
    assign s = a ^ b;
endmodule