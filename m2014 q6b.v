module top_module (
    input [3:1] y,
    input w,
    output Y2);
	
    parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;
    reg [2:0] n_state;
    
    always @(*) begin
        case (y)
            A: n_state = w ? A : B;
            B: n_state = w ? D : C;
            C: n_state = w ? D : E;
            D: n_state = w ? A : F;
            E: n_state = w ? D : E;
            F: n_state = w ? D : C;
            default: n_state = A;
        endcase
    end
    
    assign Y2 = n_state[1];
            
endmodule
