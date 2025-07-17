module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    parameter NONE = 4'd0, ONE = 4'd1, TWO = 4'd2, THREE = 4'd3, FOUR = 4'd4, FIVE = 4'd5, SIX = 4'd6, DISCARD = 4'd7, FLAG = 4'd8, ERROR = 4'd9;
    reg [3:0] c_state, n_state;
    
    always @(posedge clk) begin
        if (reset) begin
        	c_state <= NONE;
        end
        else begin
            c_state <= n_state;
        end
    end
    
    always @(*) begin
        case (c_state)
            NONE: n_state = in ? ONE : NONE;
            ONE: n_state = in ? TWO : NONE;
            TWO: n_state = in ? THREE : NONE;
            THREE: n_state = in ? FOUR : NONE;
            FOUR: n_state = in ? FIVE : NONE;
            FIVE: n_state = in ? SIX : DISCARD;
            SIX: n_state = in ? ERROR : FLAG;
            DISCARD: n_state = in ? ONE : NONE;
            FLAG: n_state = in ? ONE : NONE;
            ERROR: n_state = in ? ERROR : NONE;
        endcase
    end
    
    assign disc = (c_state == DISCARD);
    assign flag = (c_state == FLAG);
    assign err = (c_state == ERROR);
    
endmodule
