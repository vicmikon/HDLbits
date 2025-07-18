module top_module (
    input clk,
    input x,
    output z
); 
    
    wire d_in1, d_in2, d_in3, q_n1, q_n2, q_n3;
    reg q1 = 0, q2 = 0, q3 = 0;
    
    d_ff dff1 (
        .clk(clk),
        .d_in(d_in1),
        .q(q1),
        .q_n(q_n1));
    
    d_ff dff2 (
        .clk(clk),
        .d_in(d_in2),
        .q(q2),
        .q_n(q_n2));
    
    d_ff dff3 (
        .clk(clk),
        .d_in(d_in3),
        .q(q3),
        .q_n(q_n3));
    
    assign {d_in1, d_in2, d_in3, z} = {x ^ q1, x & q_n2, x | q_n3, ~(q1 | q2 | q3)};
    
    
endmodule

module d_ff (
    input clk,
    input d_in,
    output reg q,
    output q_n
); 
    
    always @(posedge clk) begin
        q <= d_in;
    end
    
    assign q_n = ~q;
    
endmodule
