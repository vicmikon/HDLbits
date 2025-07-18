module top_module (
    input clk,
    input in, 
    output reg out);
	
    wire D_in;
    
    assign D_in = in ^ out;
    
    always @(posedge clk) begin
        out <= D_in;
    end
        
endmodule
