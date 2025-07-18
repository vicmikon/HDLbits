module top_module (
    input clk,
    input [7:0] in,
    output reg[7:0] anyedge
);

    reg [7:0] anyedge_temp;
    
    always @(posedge clk) begin
        anyedge_temp <= in;
    end
    
    always @(posedge clk) begin
        anyedge <= anyedge_temp ^ in;
    end
    
endmodule
