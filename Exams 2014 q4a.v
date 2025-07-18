module top_module (
    input clk,
    input w, R, E, L,
    output reg Q
);

    wire d_in, r_in;
    
    always @(*) begin
        case(E)
            1'b0: r_in = Q;
            1'b1: r_in = w;
        endcase
    end
    
    always @(*) begin
        case(L)
            1'b0: d_in = r_in;
            1'b1: d_in = R;
        endcase
    end
    
    always @(posedge clk) begin
        Q <= d_in;
    end
    
endmodule
