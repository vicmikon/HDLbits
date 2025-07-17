module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
	
    wire p1_abc, p1_edf, p2_ab, p2_cd;
    assign {p1_abc, p1_edf, p2_ab, p2_cd} = {(p1a & p1b & p1c), (p1e & p1d & p1f), (p2a & p2b), (p2c & p2d)};
    assign p1y = p1_abc | p1_edf;
    assign p2y = p2_ab | p2_cd;
    
endmodule
