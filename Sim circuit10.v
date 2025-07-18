module top_module (
    input clk,
    input a,
    input b,
    output q,
    output reg state  );

    always @(posedge clk) begin
        if (a && b)
            state <= 1;
        else if (!a && !b)
            state <= 0;
        else
            state <= state;
    end
    
    assign q = state ? (~(a ^ b)) : (a ^ b);
    
endmodule
