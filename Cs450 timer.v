module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
    
    reg [9:0] cnt;
    
    always @(posedge clk) begin
        if (load) begin
            cnt <= data;
        end
        else begin
            if (cnt > 0)
                cnt <= cnt - 1'd1;
            else
                cnt <= 0;
        end
    end
    
    assign tc = (cnt == 0);
            
endmodule
