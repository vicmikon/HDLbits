module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
	
    parameter LEFT = 2'd0, RIGHT = 2'd1, FALL_L = 2'd2, FALL_R = 2'd3;
    reg [1:0] c_state, n_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            c_state <= LEFT;
        end
        else begin
            c_state <= n_state;
        end
    end
    
    always @(*) begin
        case(c_state)
            LEFT: n_state = (ground == 0) ? FALL_L : (bump_left ? RIGHT : LEFT);
            RIGHT: n_state = (ground == 0) ? FALL_R : (bump_right ? LEFT : RIGHT);
            FALL_L: n_state = (ground == 0) ? FALL_L : LEFT;
            FALL_R: n_state = (ground == 0) ? FALL_R : RIGHT;
            default: n_state = LEFT;
        endcase
    end
    
    assign walk_left = (c_state == LEFT);
    assign walk_right = (c_state == RIGHT);
    assign aaah = (c_state == FALL_L) || (c_state == FALL_R);
    
endmodule
