module top_module (input x, input y, output z);
	
    wire ia1_z, ib1_z, ia2_z, ib2_z;
    wire i1,i2;
    
    A IA1 (.x(x), .y(y), .z(ia1_z));
    B IB1 (.x(x), .y(y), .z(ib1_z));
    A IA2 (.x(x), .y(y), .z(ia2_z));
    B IB2 (.x(x), .y(y), .z(ib2_z));
    
    assign i1 = ia1_z | ib1_z;
    assign i2 = ia2_z & ib2_z;
    assign z = i1 ^ i2;
    
endmodule

module A (input x, input y, output z);
    
    assign z = (x^y) & x ;
    
endmodule

module B ( input x, input y, output z );
    
    assign z = ~(x^y);
    
endmodule
