module top_module (
    input clk,
    input L,
    input r_in,
    input q_in,
    output reg Q);

    wire d_in;
    
    always @(*) begin
        case(L)
            1'b0: d_in = q_in;
            1'b1: d_in = r_in;
        endcase
    end
    
    always @(posedge clk) begin
        Q <= d_in;
    end
    
endmodule
