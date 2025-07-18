module top_module (
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);
    
    reg [7:0] pedge_temp;
    
    always @(posedge clk) begin
        pedge_temp <= in;
    end
    
    always @(posedge clk) begin
        pedge <= ~pedge_temp & in;
    end
    
endmodule
