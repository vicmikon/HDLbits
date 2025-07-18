module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);

    parameter SNT = 2'd0, WNT = 2'd1, WT = 2'd2, ST = 2'd3;
    reg [1:0] n_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WNT;
        end
        else if (train_valid) begin
            state <= n_state;
        end
        else begin
            state <= state;
        end
    end
    
    always @(*) begin
        case (state)
            SNT: n_state = train_taken ? WNT : SNT;
            WNT: n_state = train_taken ? WT : SNT;
            WT: n_state = train_taken ? ST : WNT;
            ST: n_state = train_taken ? ST : WT;
        endcase
    end
    
endmodule
