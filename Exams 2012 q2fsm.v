module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    input w,
    output z
);

    parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;
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
            A: n_state = w ? B : A;
            B: n_state = w ? C : D;
            C: n_state = w ? E : D;
            D: n_state = w ? F : A;
            E: n_state = w ? E : D;
            F: n_state = w ? C : D;
            default: n_state = A;
        endcase
    end
    
    assign z = (c_state == E) || (c_state == F);
    
endmodule
