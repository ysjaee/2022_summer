module ripple_carry_adder(a,b,c_in,c_out,sum);
    input [3:0]a;
    input [3:0]b;
    input c_in;
    output c_out;
    output [3:0]sum;
    wire c1;
    wire c2;
    wire c3;

    full_adder fa(.a(a[0]),.b(b[0]),.c_in(c_in),.c_out(c1),.sum(sum[0]));
    full_adder fa1(.a(a[1]),.b(b[1]),.c_in(c1),.c_out(c2),.sum(sum[1]));
    full_adder fa2(.a(a[2]),.b(b[2]),.c_in(c2),.c_out(c3),.sum(sum[2]));
    full_adder fa3(.a(a[3]),.b(b[3]),.c_in(c3),.c_out(c_out),.sum(sum[3]));
endmodule
