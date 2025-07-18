module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    
    parameter A = 0, B = 1, C = 2, D = 3, E = 4;
    reg [2:0] c_state, n_state;
    
    always @(posedge clk) begin
        if (reset) begin
            c_state <= A;
        end
        else begin
            c_state <= n_state;
        end
    end
    
    always @(*) begin
        case (c_state)
            A: n_state = B;
            B: n_state = C;
            C: n_state = D;
            D: n_state = E;
            E: n_state = E;
            default: n_state = A;
        endcase
    end
    
    assign shift_ena = ~(c_state == E);
	
endmodule
