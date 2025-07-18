module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
	
    parameter S = 0, S1 = 1, S11 = 2, S110 = 3, B0 = 4, B1 = 5, B2 = 6, B3 = 7, COUNT = 8, WAIT = 9;
    reg [3:0] c_state, n_state;
    
    always @(posedge clk) begin
        if (reset) begin
            c_state <= S;
        end
        else begin
            c_state <= n_state;
        end
    end
    
    always @(*) begin
        case (c_state)
            S: n_state = data ? S1 : S; // 1 : 0
            S1: n_state = data ? S11 : S; // 11 : 10
            S11: n_state = data ? S11 : S110; // 110 : 111
            S110: n_state = data ? B0 : S; // 1101 : 1100
            B0: n_state = B1;
            B1: n_state = B2;
            B2: n_state = B3;
            B3: n_state = COUNT;
            COUNT: n_state = done_counting ? WAIT : COUNT;
            WAIT: n_state = ack ? S : WAIT;
            default: n_state = S;
        endcase
    end

    assign shift_ena = (c_state == B0) || (c_state == B1) || (c_state == B2) || (c_state == B3);
    assign counting = (c_state == COUNT);
    assign done = (c_state == WAIT);
    
endmodule
