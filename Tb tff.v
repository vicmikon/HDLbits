module top_module ();
	reg clk;
    reg reset;
    reg t;
    wire q;
    
    tff TFF1 (.clk(clk),
              .reset(reset),
              .t(t),
              .q(q));
    
    initial begin
        clk = 0;
        reset = 1;
        t = 0;
        #10 reset = 0;
        t = 1;
    end
        
    always begin
        #5 clk = ~clk;
    end
    
endmodule
