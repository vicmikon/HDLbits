module top_module (
    input clk,
    input j,
    input k,
    output reg Q); 

    wire d_in;
    
    assign d_in = (j & ~Q) | (~k & Q);
    
    always @(posedge clk) begin
        Q <= d_in;
    end
    
endmodule
