module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);

    bcd_count bcd1(
        .clk(clk),
        .reset(reset),
        .ena(1),
        .q(q0));
    
    bcd_count bcd2(
        .clk(clk),
        .reset(reset),
        .ena(ena[1]),
        .q(q1));
    
    bcd_count bcd3(
        .clk(clk),
        .reset(reset),
        .ena(ena[2]),
        .q(q2));
    
    bcd_count bcd4(
        .clk(clk),
        .reset(reset),
        .ena(ena[3]),
        .q(q3));
    
    wire [3:0] q0, q1, q2, q3;
    
    assign q = {q3, q2, q1, q0};
    assign ena = {{(q0 == 4'd9) && (q1 == 4'd9) && (q2 == 4'd9)}, {(q0 == 4'd9) && (q1 == 4'd9)}, {q0 == 4'd9}};
    
endmodule

module bcd_count (
    input clk,
    input reset,        // Synchronous active-high reset
    input ena,
    output reg [3:0] q);
	
    always @(posedge clk) begin
        if (reset) begin
            q <= 0;
        end
        else begin
            if (!ena)
                q <= q;
            else if (ena && q < 4'd9)
                q <= q + 1;
            else
                q <= 0;
        end
    end
    
endmodule
