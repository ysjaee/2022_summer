module xor_gate_3input(a,b,c,out);
    input a;
    input b;
    input c;
    output out;

    assign out = (((~a && b) || (a && ~b)) && ~c) || (~((~a && b) || (a && ~b)) && c);
endmodule