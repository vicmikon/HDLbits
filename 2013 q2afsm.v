module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 

    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
    reg [1:0] c_state, n_state;
    
    always @(posedge clk) begin
        if (!resetn) begin
            c_state <= A;
        end
        else begin
            c_state <= n_state;
        end
    end
    
    always @(*) begin
        case (c_state)
            A: begin
                casex (r)
                    3'b000: n_state = A;
                    3'bxx1: n_state = B;
                    3'bx10: n_state = C;
                    3'b100: n_state = D;
                    default: n_state = A;
                endcase
            end
            B: n_state = r[1] ? B : A;
            C: n_state = r[2] ? C : A;
            D: n_state = r[3] ? D : A;
        endcase
    end
    
    assign g = {(c_state == D), (c_state == C), (c_state == B)};
    
endmodule
