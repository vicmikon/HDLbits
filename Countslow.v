module top_module (
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 0;
        end
        else begin
            if (slowena) begin
                if(q < 4'd9)
                    q <= q + 1;
            	else
                    q <= 0;
            end
            else begin
                q <= q;
            end
        end     
    end
    
endmodule
