module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q ); 

    wire [255:0] q_next;
    reg [323:0] data_padding;
    reg [3:0] sum;
    int i, j;
    
    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= q_next;
    end
    
    always @(*) begin
        data_padding[17:0] = {q[240], q[255:240], q[255]};
        data_padding[323:306] = {q[0], q[15:0], q[15]};

        for (i = 1; i < 17; i = i + 1)
            data_padding[i*18 +: 18] = {q[(i-1)*16], q[(i-1)*16 +: 16], q[i*16-1]};
    end
    
    always @(*) begin
        for (i = 0; i < 16; i = i + 1) begin // row
            for (j = 0; j < 16; j = j + 1) begin // column
                sum = data_padding[(i+1)*18+j+1-1] + data_padding[(i+1)*18+j+1+1] + data_padding[i*18+j+1-1] + data_padding[i*18+j+1] + data_padding[i*18+j+1+1] + data_padding[(i+2)*18+j+1-1] + data_padding[(i+2)*18+j+1] + data_padding[(i+2)*18+j+1+1];
                // left + right + lowerleft + lower + lowerright + topleft + top + topright
                if (sum <= 1 || sum >= 4)
                    q_next[i*16+j] = 0;
                else if(sum == 3)
                    q_next[i*16+j] = 1;
                else
                    q_next[i*16+j] = q[i*16+j];
            end
        end
    end
endmodule
