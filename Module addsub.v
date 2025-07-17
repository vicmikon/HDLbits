module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire [15:0] sum1, sum2;
    wire cin, cout;
    wire [31:0] bin;
    
    assign bin = b ^ {32{sub}};
    
    add16 add16 (a[15:0], bin[15:0], sub, sum1, cin);
    add16 add16_2 (a[31:16], bin[31:16], cin, sum2, cout);
    
    assign sum = {sum2, sum1};
    
endmodule
