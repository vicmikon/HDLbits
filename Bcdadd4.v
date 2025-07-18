module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
	
    wire [2:0] co_temp;
    
    bcd_fadd add[3:0] (
        .a(a[15:0]),
        .b(b[15:0]),
        .cin({co_temp[2:0], cin}),
        .cout({cout, co_temp[2:0]}),
        .sum(sum[15:0]));
    
endmodule
