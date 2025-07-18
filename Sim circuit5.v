module top_module (
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q );
	
    always @(*) begin
        case(c)
            4'b0000: q = b;
            4'b0001: q = e;
            4'b0010: q = a;
            4'b0011: q = d;
            default: q = 4'hf;
        endcase
    end
    
endmodule
