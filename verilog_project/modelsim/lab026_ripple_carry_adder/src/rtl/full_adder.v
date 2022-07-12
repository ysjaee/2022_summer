module full_adder(a,b,c_in,c_out,sum);
    input a;
    input b;
    input c_in;
    output c_out;
    output sum;
    wire c1;
    wire c2;
    wire s;
    half_adder ha(.a(a),.b(b),.c(c1),.s(s));
    half_adder ha1(.a(s),.b(c_in),.c(c2),.s(sum));

    assign c_out = c1 || c2;
endmodule
