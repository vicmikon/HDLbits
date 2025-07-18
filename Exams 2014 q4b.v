module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
);
    
    MUXDFF mux_d0 (
        .clk(KEY[0]),
        .w(LEDR[1]),
        .R(SW[0]),
        .E(KEY[1]),
        .L(KEY[2]),
        .Q(LEDR[0]));
    
    MUXDFF mux_d1 (
        .clk(KEY[0]),
        .w(LEDR[2]),
        .R(SW[1]),
        .E(KEY[1]),
        .L(KEY[2]),
        .Q(LEDR[1]));
    
    MUXDFF mux_d2 (
        .clk(KEY[0]),
        .w(LEDR[3]),
        .R(SW[2]),
        .E(KEY[1]),
        .L(KEY[2]),
        .Q(LEDR[2]));
    
    MUXDFF mux_d3 (
        .clk(KEY[0]),
        .w(KEY[3]),
        .R(SW[3]),
        .E(KEY[1]),
        .L(KEY[2]),
        .Q(LEDR[3]));

endmodule

module MUXDFF (
    input clk,
    input w, R, E, L,
    output reg Q
);

    reg d_in, r_in;
    
    always @(*) begin
        case(E)
            1'b0: r_in = Q;
            1'b1: r_in = w;
        endcase
    end
    
    always @(*) begin
        case(L)
            1'b0: d_in = r_in;
            1'b1: d_in = R;
        endcase
    end
    
    always @(posedge clk) begin
        Q <= d_in;
    end
    
endmodule
