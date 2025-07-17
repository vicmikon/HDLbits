module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //

    // Use FSM from Fsm_serial
    
    parameter IDLE = 3'd0, START = 3'd1, STOP = 3'd2, WAIT = 3'd3, ERROR = 3'd4;
    reg [2:0] c_state, n_state;
    reg [3:0] cnt;
    reg [7:0] store; 
    
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
            cnt <= 4'd0;
        end
        else begin
            if (c_state == START)
                cnt <= cnt + 4'd1;
            else
                cnt <= 4'd0;
        end
    end
    
    always @(*) begin
        case (c_state)
            IDLE: n_state = in ? IDLE : START;
            START: n_state = (cnt == 4'd7) ? WAIT : START;
            WAIT: n_state = in ? STOP : ERROR;
            STOP: n_state = in ? IDLE : START;
            ERROR: n_state = in ? IDLE : ERROR;
            default: n_state = IDLE;
        endcase
    end
    
    assign done = (c_state == STOP);

    // New: Datapath to latch input bits. 11010010 01001011
    
    always @(posedge clk) begin
        if (reset) begin
            store <= 8'd0;
        end
        else begin
            store[cnt] <= (c_state == START) ? in : 1'd0;
    	end
    end
    
    assign out_byte = (c_state == STOP) ? store : 8'd0;

endmodule
