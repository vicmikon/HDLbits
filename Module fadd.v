module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] sum1,sum2;
    wire cout;
    
    add16 add16 (a[15:0], b[15:0], 0, sum1, cout);
    add16 add16_2 (a[31:16], b[31:16], cout, sum2, 0);
    assign sum = {sum2, sum1};
    
endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );

    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (cin & a);

endmodule
