module full_adder(a,b,cin,cout,s);
    input a;
    input b;
    input cin;
    output cout;
    output s;
    wire c0;
    wire c1;
    wire s0;

    half_adder ha0(.a(a),.b(b),.c(c0),.s(s0));
    half_adder ha1(.a(s0),.b(cin),.c(c1),.s(s));
    assign cout = c1 || c0;
endmodule