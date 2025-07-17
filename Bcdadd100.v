module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
	
    wire [99:0] co_temp;
    
    bcd_fadd bcd(
        .a(a[3:0]),
        .b(b[3:0]),
        .cin(cin),
        .cout(co_temp[0]),
        .sum(sum[3:0]));
    
    genvar i;
    generate
        for (i = 1; i < 100; i = i + 1) begin: BCD
            bcd_fadd inst(
                .a(a[4*i+3:4*i]),
                .b(b[4*i+3:4*i]),
                .cin(co_temp[i-1]),
                .cout(co_temp[i]),
                .sum(sum[4*i+3:4*i]));
        end
    endgenerate
    
    assign cout = co_temp[99];
    
endmodule
