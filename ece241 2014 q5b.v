module top_module (
    input clk,
    input areset,
    input x,
    output reg z
); 

    parameter A = 1'b0, B = 1'b1;
    reg c_state, n_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            c_state <= A;
        end
        else begin
            c_state <= n_state;
        end
    end
    
    always @(*) begin
        case (c_state)
            A: n_state = x ? B : A;
            B: n_state = B;
            default: n_state = A;
        endcase
    end
    
    always @(*) begin
        case (c_state)
            A: z = x;
            B: z = ~x;
            default: z = 1'bx;
        endcase
    end
    
endmodule
