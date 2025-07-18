module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q
	
    muxdff mux_d2(
        .clk(KEY[0]),
        .L(KEY[1]),
        .r_in(SW[2]),
        .q_in(LEDR[2] ^ LEDR[1]),
        .Q(LEDR[2]));
    
    muxdff mux_d1(
        .clk(KEY[0]),
        .L(KEY[1]),
        .r_in(SW[1]),
        .q_in(LEDR[0]),
        .Q(LEDR[1]));
    
    muxdff mux_d0(
        .clk(KEY[0]),
        .L(KEY[1]),
        .r_in(SW[0]),
        .q_in(LEDR[2]),
        .Q(LEDR[0]));
    
endmodule

module muxdff (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);

    reg d_in;
    
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
