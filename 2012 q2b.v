module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    
    reg [5:0] n_state;
    
    assign n_state[0] = (y[0] || y[4]) && ~w;
    assign n_state[1] = y[0] & w;
    assign n_state[2] = (y[1] || y[5]) && w;
    assign n_state[3] = (y[1] || y[2] || y[4] || y[5]) && ~w;
    assign n_state[4] = (y[2] || y[4]) && w;
    assign n_state[5] = y[3] && w;
    
    assign Y1 = n_state[1];
    assign Y3 = n_state[3];

endmodule
