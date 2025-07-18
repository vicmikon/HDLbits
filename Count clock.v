module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    always @(posedge clk) begin
        if (reset) begin
            ss[7:0] <= 0;
        end
        else begin
            if (ena) begin
                if (ss[3:0] < 4'd9)
                    ss[3:0] <= ss[3:0] + 4'd1;
                else if (ss[7:0] == 8'h59)
                    ss[7:0] <= 0;
                else begin
                    ss[7:4] <= ss[7:4] + 4'd1;
                	ss[3:0] <= 0;
                end
            end
            else begin
                ss[7:0] <= ss[7:0];
            end
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            mm[7:0] <= 0;
        end
        else begin
            if (ena && ss[7:0] == 8'h59) begin
                if (mm[3:0] < 4'd9)
                    mm[3:0] <= mm[3:0] + 4'd1;
                else if (mm[7:0] == 8'h59)
                    mm[7:0] <= 0;
                else begin
                    mm[7:4] <= mm[7:4] + 4'd1;
                    mm[3:0] <= 0;
                end
            end
            else begin
                mm[7:0] <= mm[7:0];
            end
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            hh[7:0] <= 8'h12;
        end
        else begin
            if (ena && ss[7:0] == 8'h59 && mm[7:0] == 8'h59) begin
                if (hh[3:0] < 4'd9 && hh[7:0] != 8'h12)
                    hh[3:0] <= hh[3:0] + 4'd1;
                else if (hh[7:0] == 8'h12)
                    hh[7:0] <= 8'h1;
                else begin
                    hh[7:4] <= 4'd1;
                    hh[3:0] <= 0;
                end
            end
        	else begin
            	hh[7:0] <= hh[7:0];
        	end
    	end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            pm <= 0;
        end
    	else begin
            if (hh[7:0] == 8'h11 && mm[7:0] == 8'h59 && ss[7:0] == 8'h59)
                pm <= ~pm;
            else
                pm <= pm;
        end
    end

endmodule
