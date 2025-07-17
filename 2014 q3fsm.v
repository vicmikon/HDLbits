module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);

    parameter A = 1'b0, B= 1'b1;
    reg c_state, n_state;
    reg [1:0] cnt, cnt_w;
    
    always @(posedge clk) begin
        if (reset) begin
            c_state <= A;
        end
        else begin
            c_state <= n_state;
        end
    end
    
    always @(*) begin
        case (c_state)
            A: n_state = s ? B : A;
            B: n_state = B;
            default: n_state = A;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            cnt <= 2'd0;
        end
        else begin
            if (c_state == B && cnt < 2'd2)
                cnt <= cnt + 2'd1;
            else
                cnt <= 2'd0;
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            cnt_w <= 2'd0;
        end
        else begin
            if (c_state == B) begin
                if (cnt == 2'd0 && w)
                    cnt_w <= 2'd1;
                else if (cnt == 2'd0 && !w)
                    cnt_w <= 2'd0;
                else if (cnt !== 2'd0 && w)
                    cnt_w <= cnt_w + 2'd1;
                else
                    cnt_w <= cnt_w;
            end
            else begin
                cnt_w <= 2'd0;
            end
        end
    end
    
    assign z = (cnt == 2'd0 && cnt_w == 2'd2);
    
endmodule
