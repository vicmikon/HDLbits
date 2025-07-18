module top_module( 
    input a, b, cin,
    output cout, sum );

    assign {sum, cout} = {a ^ b ^ cin, (a & b) | (b & cin) | (cin & a)};
    
endmodule
