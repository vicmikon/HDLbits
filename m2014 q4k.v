module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output reg out);
	
    reg [2:0] temp;
    
    always @(posedge clk) begin
        if (!resetn)
            out <= 1'd0;
        else
            out <= temp[0];
    end
    
    always @(posedge clk) begin
        if (!resetn)
            temp <= 3'd0;
        else
            temp[2:0] <= {in, temp[2], temp[1]};
    end
    
endmodule
