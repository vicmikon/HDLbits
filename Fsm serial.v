module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 

    parameter IDLE = 3'd0, START = 3'd1, STOP = 3'd2, WAIT = 3'd3, ERROR = 3'd4;
    reg [2:0] c_state, n_state;
    int cnt;
    
    always @(posedge clk) begin
        if (reset) begin
            c_state <= IDLE;
        end
        else begin
            c_state <= n_state;
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            cnt <= 0;
        end
        else begin
            if (c_state == START)
                cnt <= cnt + 1;
            else
                cnt <= 0;
        end
    end
    
    always @(*) begin
        case (c_state)
            IDLE: n_state = in ? IDLE : START;
            START: n_state = (cnt == 7) ? WAIT : START;
            WAIT: n_state = in ? STOP : ERROR;
            STOP: n_state = in ? IDLE : START;
            ERROR: n_state = in ? IDLE : ERROR;
            default: n_state = IDLE;
        endcase
    end
    
    assign done = (c_state == STOP);
    
endmodule
