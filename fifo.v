`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2026 18:28:10
// Design Name: 
// Module Name: fifo
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


module fifo#(parameter width = 8,
             parameter depth = 8)(
             
    input clk,
    input rst,
    input [width-1:0]datain,
    input wr_en,
    input rd_en,
    output full,
    output empty,
    output reg [width-1:0] dataout
    
    );
    //creating memory space(m- memory)
    reg [width-1:0]m[0:depth-1];
    
    //creating pointers for reading/writing
    reg [$clog2(depth)-1:0]wr_ptr; //write pointer of 3 bit
    
    reg [$clog2(depth)-1:0]rd_ptr; //read pointer of 3 bit 
    
    assign empty = (wr_ptr == rd_ptr); //empty condition
    assign full = ((wr_ptr+1) == rd_ptr); //full condition with 'wrap around' logic
    
   
   //Sequential block
    
    always@(posedge clk or posedge rst)
    begin
        if(rst) begin
             wr_ptr <=0;
             rd_ptr <=0;
             dataout <=0;
        end
        
        else
            begin
                if(wr_en && (!full || rd_en)) //simultaneous condition used  
                begin
                    m[wr_ptr] <= datain; //input is stored in the memory location pointed by wr_ptr
                    wr_ptr <= wr_ptr + 1; // increment of pointer to nexxt memory location
                end
                
                //output
                if(rd_en && !empty) // simultaneous condition is not used to prevent reading data , when memory is empty
                begin
                    dataout <= m[rd_ptr]; 
                    rd_ptr <= rd_ptr + 1;
                end
            end
        end        

endmodule
