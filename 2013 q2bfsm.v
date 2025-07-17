module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 

    parameter A = 4'd0, RST = 4'd1, IDLE = 4'd2, S1 = 4'd3, S10 = 4'd4, S101 = 4'd5, SY1 = 4'd6, SY0 = 4'd7, SY00 = 4'd8;
    reg [3:0] c_state, n_state;
    
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
            A: n_state = RST;
            RST: n_state = IDLE;
            IDLE: n_state = x ? S1 : IDLE;
            S1: n_state = x ? S1 : S10;
            S10: n_state = x ? S101 : IDLE;
            
            S101: n_state = y ? SY1 : SY0;
            SY0: n_state = y ? SY1 : SY00;
            SY1: n_state = SY1;
            SY00: n_state = SY00;
        endcase
    end
    
    assign f = (c_state == RST);
    assign g = (c_state == S101) || (c_state == SY0) || (c_state == SY1);
    
endmodule
