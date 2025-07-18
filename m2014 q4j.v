module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    
    wire cin;
    wire [3:0] cout;
    
	FA FA1(
        .x(x[0]),
        .y(y[0]),
        .cin(cin),
        .cout(cout[0]),
        .sum(sum[0]));
    
    genvar i;
    generate
        for (i = 1; i < 4; i = i + 1) begin: ADD
            FA inst(
                .x(x[i]),
                .y(y[i]),
                .cin(cout[i-1]),
                .cout(cout[i]),
                .sum(sum[i]));
        end
    endgenerate
    
    assign sum[4] = cout[3];
    
endmodule

module FA( 
    input x, y, cin,
    output cout, sum );

    assign {sum, cout} = {x ^ y ^ cin, (x & y) | (y & cin) | (cin & x)};
    
endmodule
