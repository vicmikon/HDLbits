module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);

    reg [6:1] n_state;
    
    assign n_state[1] = (y[1] || y[4]) && w;
    assign n_state[2] = y[1] & ~w;
    assign n_state[3] = (y[2] || y[6]) && ~w;
    assign n_state[4] = (y[2] || y[3] || y[5] || y[6]) && w;
    assign n_state[5] = (y[3] || y[5]) && ~w;
    assign n_state[6] = y[4] && ~w;
    
    assign Y2 = n_state[2];
    assign Y4 = n_state[4];
    
endmodule
