module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input signed [63:0] data,
    output reg signed [63:0] q); 
	
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            if (ena) begin
                case (amount)
                    2'b00: q <= q <<< 1'd1;
                    2'b01: q <= q <<< 4'd8;
                    2'b10: q <= q >>> 1'd1;
                    2'b11: q <= q >>> 4'd8;
                endcase
            end
            else begin
                q <= q;
            end
        end
    end
    
endmodule
