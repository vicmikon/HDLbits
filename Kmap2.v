module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
	
    assign out = (~b & ~c) | (~d & ~a) | (c & d & b) | (c & d & a);
    
endmodule
