module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);
	
    reg [31:0] out_temp;
    
    always @(posedge clk) begin
		out_temp <= in;
    end
    
    always @(posedge clk) begin
        if (reset)
            out <= 0;
        else
            out <= out_temp & ~in | out;
    end
    
endmodule
