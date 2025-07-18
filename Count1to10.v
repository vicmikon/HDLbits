module top_module (
    input clk,
    input reset,
    output reg [3:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 1;
        end
        else begin
            if (q < 10)
                q <= q + 1;
            else
                q <= 1;
        end
    end
    
endmodule
