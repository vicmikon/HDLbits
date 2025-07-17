module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output reg [7:0] out_byte,
    output reg done
); //

    // Modify FSM and datapath from Fsm_serialdata
    
    parameter IDLE = 3'd0, START = 3'd1, DATA = 3'd2, STOP = 3'd3, ERROR = 3'd4;
    reg [2:0] c_state, n_state;
    reg [3:0] cnt;
    reg [8:0] store;
    wire rst_parity;
    reg odd;
    
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
            if (n_state == DATA)
                cnt <= cnt + 4'd1;
            else
                cnt <= 4'd0;
        end
    end
    
    always @(*) begin
        case (c_state)
            IDLE: n_state = in ? IDLE : START;
            START: n_state = DATA;
            DATA: n_state = (cnt == 4'd9 && in) ? STOP : ((cnt == 4'd9 && !in) ? ERROR : DATA);
            STOP: n_state = in ? IDLE : START;
            ERROR: n_state = in ? IDLE : ERROR;
            default: n_state = IDLE;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
    		done <= 1'd0;
        end
        else begin
            if (n_state == STOP && odd)
                done <= 1'd1;
            else
                done <= 1'd0;            
        end
    end

    // New: Datapath to latch input bits.
    
    always @(posedge clk) begin
        if (reset) begin
            store <= 9'd0;
        end
        else begin
            if (n_state == START || n_state == DATA)
                store[cnt] <= in;
            else
                store <= store;
    	end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            out_byte <= 8'd0;
        end
        else begin
            if (n_state == STOP && odd)
                out_byte <= store[7:0];
            else
                out_byte <= out_byte;
        end
    end

    // New: Add parity checking.
    
    parity parity (
        .clk(clk),
        .reset(rst_parity),
        .in(in),
        .odd(odd));
    
    assign rst_parity = (reset || n_state == IDLE || n_state == START);

endmodule
