module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
); 
    parameter BELOW = 3'd0, BT_S12 = 3'd1, BT_S21 = 3'd2, BT_S23 = 3'd3, BT_S32 = 3'd4, ABOVE = 3'd5;
    reg [2:0] c_state, n_state;
    
    always @(posedge clk) begin
        if (reset) begin
            c_state <= BELOW;
        end
        else begin
            c_state <= n_state;
        end
    end
    
    always @(*) begin
        case(c_state)
            BELOW: n_state = s[1] ? BT_S12 : BELOW;
            BT_S12: n_state = s[2] ? BT_S23 : (s[1] ? BT_S12 : BELOW);
            BT_S21: n_state = s[2] ? BT_S23 : (s[1] ? BT_S21 : BELOW);
            BT_S23: n_state = s[3] ? ABOVE : (s[2] ? BT_S23 : BT_S21);
            BT_S32: n_state = s[3] ? ABOVE : (s[2] ? BT_S32 : BT_S21);
            ABOVE: n_state = s[3] ? ABOVE : BT_S32;
            default: n_state = BELOW;
        endcase
    end
    
    always @(*) begin
        case(c_state)
            BELOW: {fr3, fr2, fr1, dfr} = 4'b1111;
            BT_S12: {fr3, fr2, fr1, dfr} = 4'b0110;
            BT_S21: {fr3, fr2, fr1, dfr} = 4'b0111;
            BT_S23: {fr3, fr2, fr1, dfr} = 4'b0010;
            BT_S32: {fr3, fr2, fr1, dfr} = 4'b0011;
            ABOVE: {fr3, fr2, fr1, dfr} = 4'b0000;
            default: {fr3, fr2, fr1, dfr} = 4'b1111;
        endcase
    end
    
endmodule
