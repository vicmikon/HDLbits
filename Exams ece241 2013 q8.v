module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
	
    parameter IDLE = 2'd0, S1 = 2'd1, S2 = 2'd2;
    reg [1:0] c_state, n_state;
    
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            c_state <= IDLE;
        end
        else begin
            c_state <= n_state;
        end
    end
    
    always @(*) begin
        case (c_state)
            IDLE: n_state = x ? S1 : IDLE;
            S1 : n_state = x ? S1 : S2;
            S2 : n_state = x ? S1 : IDLE;
        endcase
    end
    
    assign z = (c_state == S2) && (x == 1'd1);
    
endmodule
