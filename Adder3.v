module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
    
    full_adder fadd1(
        .a(a[0]),
        .b(b[0]),
        .cin(cin),
        .cout(cout[0]),
        .sum(sum[0]));
    
    genvar i;
    generate
        for (i = 1; i < 3; i = i + 1) begin: ADD
            full_adder inst(
                .a(a[i]),
                .b(b[i]),
                .cin(cout[i-1]),
                .cout(cout[i]),
                .sum(sum[i]));
        end
    endgenerate
    
endmodule

module full_adder( 
    input a, b, cin,
    output cout, sum );

    assign {sum, cout} = {a ^ b ^ cin, (a & b) | (b & cin) | (cin & a)};
    
endmodule
