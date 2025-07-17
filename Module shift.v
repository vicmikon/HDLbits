module top_module ( input clk, input d, output q );
    
    wire d2,d3;
    
    my_dff my_dff ( clk,d,d2 );
    my_dff my_dff2 ( clk,d2,d3 );
    my_dff my_dff3 ( clk,d3,q );
        
endmodule
