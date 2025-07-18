module top_module(
    input clk,
    input areset,

    input predict_valid,
    input predict_taken,
    output reg [31:0] predict_history,

    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_history <= 0;
        end
        else begin
            if (train_mispredicted)
                predict_history <= {train_history[30:0], train_taken};
            else if (predict_valid)
                predict_history <= {predict_history[30:0], predict_taken};
            else
                predict_history <= predict_history;
        end
    end
    
endmodule
