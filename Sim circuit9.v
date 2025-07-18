module top_module (
    input clk,
    input a,
    output reg [3:0] q );

    always @(posedge clk) begin
        if (a)
            q <= 3'd4;
        else if (q < 3'd6)
            q <= q + 1'd1;
        else
            q <= 0;
    end
    
endmodule
