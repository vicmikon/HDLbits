module top_module();
    reg [1:0] in;
    wire out;
    
    andgate AND1 (.in(in), .out(out));
    
    initial begin
        in = 0;
        #10 in[0] = 1;
        #10 in = ~in;
        #10 in[0] = 1;
    end
 
endmodule
