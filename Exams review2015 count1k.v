module top_module (
    input clk,
    input reset,
    output reg [9:0] q);
    
    always @(posedge clk) begin
        if (reset) begin
            q <= 0;
        end
        else begin
            if (q < 10'd999)
                q <= q + 1'd1;
            else
                q <= 1'd0;
        end
    end
    
endmodule
