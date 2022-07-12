module half_substractor(x,y,b,d);
    input x;
    input y;
    output b;
    output d;

    assign b = ~x & y;
    assign d = x ^ y;
endmodule
