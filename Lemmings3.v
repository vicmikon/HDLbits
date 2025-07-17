module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    parameter LEFT = 3'd0, RIGHT = 3'd1, DIG_L = 3'd2, DIG_R = 3'd3, FALL_L = 3'd4, FALL_R = 3'd5;
    reg [2:0] c_state, n_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            c_state <= LEFT;
        end
        else begin
            c_state <= n_state;
        end
    end
    
    always @(*) begin
        case (c_state)
            LEFT: n_state = (ground == 0) ? FALL_L : (dig ? DIG_L : (bump_left ? RIGHT : LEFT));
            RIGHT: n_state = (ground == 0) ? FALL_R : (dig ? DIG_R : (bump_right ? LEFT : RIGHT));
            DIG_L: n_state = (ground == 0) ? FALL_L : DIG_L;
            DIG_R: n_state = (ground == 0) ? FALL_R : DIG_R;
            FALL_L: n_state = (ground == 0) ? FALL_L : LEFT;
            FALL_R: n_state = (ground == 0) ? FALL_R : RIGHT;
        endcase
    end
    
    assign walk_left = (c_state == LEFT);
    assign walk_right = (c_state == RIGHT);
    assign aaah = (c_state == FALL_L) || (c_state == FALL_R);
    assign digging = (c_state == DIG_L) || (c_state == DIG_R);
    
endmodule
