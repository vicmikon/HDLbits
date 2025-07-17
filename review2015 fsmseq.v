module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);

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
            A: n_state = data ? B : A; // 1 : 0
            B: n_state = data ? C : A; // 11 : 10
            C: n_state = data ? C : D; // 110 : 111
            D: n_state = data ? E : A; // 1101 : 1100
            E: n_state = E;
            default: n_state = A;
        endcase
    end
    
    assign start_shifting = (c_state == E);
    
endmodule
