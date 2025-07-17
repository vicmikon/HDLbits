module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //
	
    parameter BYTE1 = 2'd0, BYTE2 = 2'd1, BYTE3 = 2'd2, DONE = 2'd3;
    reg [1:0] c_state, n_state;
    
    // State transition logic (combinational)
    always @(*) begin
        case(c_state)
            BYTE1: n_state = in[3] ? BYTE2 : BYTE1;
            BYTE2: n_state = BYTE3;
            BYTE3: n_state = DONE;
            DONE: n_state = in[3] ? BYTE2 : BYTE1;
            default: n_state = BYTE1;
        endcase
    end
    
    // State flip-flops (sequential)
    always @(posedge clk) begin
        if(reset) begin
            c_state <= BYTE1;
        end
        else begin
            c_state <= n_state;
        end
    end
    
    // Output logic
    assign done = (c_state == DONE);

endmodule
