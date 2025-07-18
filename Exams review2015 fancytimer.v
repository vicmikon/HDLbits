module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    
    parameter S = 0, S1 = 1, S11 = 2, S110 = 3, B0 = 4, B1 = 5, B2 = 6, B3 = 7, COUNT = 8, WAIT = 9;
    reg [3:0] c_state, n_state, delay;
    wire shift_ena, done_counting;
    reg [13:0] cnt;
    reg [9:0] cnt1000;
    
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
    assign done_counting = (delay == 0 && cnt1000 == 10'd999);
    assign count = delay;
    assign done = (c_state == WAIT);
    
    always @(posedge clk) begin
        if (reset) begin
            delay <= 0;
        end
        else begin
            if (shift_ena)
                delay <= {delay[2:0], data};
            else if (counting && cnt1000 == 10'd999)
                delay <= delay - 1'd1;
            else
                delay <= delay;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            cnt <= 0;
        end
        else begin
            if (counting)
                cnt <= cnt + 1'd1;
        	else
                cnt <= 0;
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            cnt1000 <= 0;
        end
        else begin
            if (counting && cnt1000 < 10'd999)
                cnt1000 <= cnt1000 + 1'd1;
        	else
                cnt1000 <= 0;
        end
    end

endmodule
