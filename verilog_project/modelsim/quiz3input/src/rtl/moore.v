module moore(clk,rst_n,in0,in1,in2,out);
    input clk;
    input rst_n;
    output in0, in1, in2;
    output out;
    reg in0;
    reg in1;
    reg [2:0]c_state;
    reg [2:0]n_state;
    wire a,b,c;
    parameter s0 = 3'b000;
    parameter s1 = 3'b001;
    parameter s2 = 3'b010;
    parameter s3 = 3'b011;
    parameter s4 = 3'b100;
    parameter s5 = 3'b101;
    parameter s6 = 3'b110;
    parameter s7 = 3'b111;


    always @ (posedge clk or negedge rst_n)
        if (!rst_n)
            c_state <= 3'b000;
        else
            c_state <= n_state;

    always @(c_state or clk) begin
        case(c_state)
        s0:begin
            n_state = s1;
        end
        s1:begin
            n_state = s2;
        end
        s2:begin
            n_state = s3;
        end
        s3:begin
            n_state = s4;          
        end
        s4:begin
            n_state = s5;
        end
        s5:begin
            n_state = s6;
        end
        s6:begin
            n_state = s7;
        end
        s7:begin
            n_state = s0;
        end
        default:begin
            n_state = s0;
        end
        endcase
    end
    assign {a,b,c} = c_state;
    assign in0 = a;
    assign in1 = b;
    assign in2 = c;
    assign  out = a & b & c;
        
         
endmodule    

    