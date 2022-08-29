module moore(clk,rst_n,in0,in1,out);
    input clk;
    input rst_n;
    output in0, in1;
    output out;
    reg in0;
    reg in1;
    reg [1:0]c_state;
    reg [1:0]n_state;
    wire a,b;
    parameter s0 = 2'b00;
    parameter s1 = 2'b01;
    parameter s2 = 2'b10;
    parameter s3 = 2'b11;
    parameter step = 5;
    reg [4:0]cnt;


    always @ (posedge clk or negedge rst_n)
        if (!rst_n) begin
            c_state <= 2'b00;
            cnt = 0;
        end
        else    
        begin    
            cnt <= cnt+1;
            if (cnt == step) 
            begin
                c_state <= n_state;
                cnt <= 0;
            end
        end
        

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
            n_state = s0;          
        end
        default:begin
            n_state = s0;
        end
        endcase
    end
    assign {a,b} = c_state;
    assign in0 = a;
    assign in1 = b;
    assign  out = a & b;
        
         
endmodule    

    