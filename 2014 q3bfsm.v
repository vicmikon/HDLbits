module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);

    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;
    reg [2:0] c_state, n_state;
    
    always @(posedge clk) begin
        if (reset)
            c_state <= S0;
        else
            c_state <= n_state;
    end
    
    always @(*) begin
        case (c_state)
            S0: n_state = x ? S1 : S0;
            S1: n_state = x ? S4 : S1;
            S2: n_state = x ? S1 : S2;
            S3: n_state = x ? S2 : S1;
            S4: n_state = x ? S4 : S3;
            default: n_state = S0;
        endcase
    end
    
    assign z = (c_state == S3) || (c_state == S4);
    
endmodule
