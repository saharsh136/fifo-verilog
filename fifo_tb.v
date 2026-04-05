`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2026 19:34:15
// Design Name: 
// Module Name: fifo_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


    module fifo_tb;
    
        parameter width = 8;
        parameter depth = 8;
    
        reg clk;
        reg rst;
        reg wr_en;
        reg rd_en;
        reg [width-1:0] datain;
    
        wire [width-1:0] dataout;
        wire full;
        wire empty;
        
        fifo dut(.rd_en(rd_en), .clk(clk), .rst(rst), .wr_en(wr_en), .datain(datain), .dataout(dataout), .full(full), .empty(empty));
        
        always #5 clk = ~clk;
        initial 
        begin
            clk = 0;
            rst = 1;
            wr_en = 0;
            rd_en = 0;
            datain =0;
        
        #10;
        rst =0;
        
        
       //writing data
        repeat(7)
        begin
            @(posedge clk);
            wr_en = 1;
            datain = datain + 8'd5; 
        end
        
        //stop writing
        @(posedge clk) begin
            wr_en = 0;
        end
        
               
        
        //reading values
        repeat(7)
            begin
                @(posedge clk);begin
                    rd_en = 1;
                    end
            end
            
        
        @(posedge clk) begin
        
            rd_en = 0;
        end
        
        // checking the simulatneous logic
        repeat(5)
        begin
            @(posedge clk);
                rd_en = 1;
                wr_en = 1;
                datain = datain + 8'd9;
        end
        @(posedge clk) begin
            wr_en = 0;
            rd_en = 0;
        end
        rd_en = 1;
        #30;
        
        $finish;
        
        end
    
    
       //monitoring the values 
       initial 
        begin
            $monitor("Time=%0t | wr_en=%b rd_en=%b | din=%0d dout=%0d | full=%b empty=%b", 
            $time, wr_en, rd_en, datain, dataout, full, empty);
        end
    
    endmodule
