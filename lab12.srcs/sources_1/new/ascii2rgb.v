`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2022 01:23:03 PM
// Design Name: 
// Module Name: ascii2rgb
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


module ascii2rgb(
    input clk,
    input [8:0]ascii_data,
    input [3:0]font_h,
    input [3:0]font_v,
    input white, 
    input blue,
    input red,
    input rainbow,
    output reg [11:0]rgb_data
    );
    
    reg [11:0] myfont[4159:0];
    wire [11:0]line;
    wire [11:0]rgbs;
    initial begin
        $readmemh("D:/Xilinx/Project/lab09/vga_font.txt", myfont, 0, 4159);
    end
    assign line = myfont[{ascii_data, font_v}];
    assign rgbs = line[font_h];
    reg [2:0]rainbow_cnt = 0;
    always @ (negedge clk) begin
        if(font_h == 0) begin
            if(rainbow_cnt == 3'b110) rainbow_cnt <= 0;
            else rainbow_cnt <= rainbow_cnt + 1;
        end
        if(rainbow)begin
            case(rainbow_cnt)
                3'b000 : rgb_data <= (rgbs == 1) ? 12'b111100000000 : 12'b111111111111;  
                3'b001 : rgb_data <= (rgbs == 1) ? 12'b000011110000 : 12'b111111111111;  
                3'b010 : rgb_data <= (rgbs == 1) ? 12'b000000001111 : 12'b111111111111;  
                3'b011 : rgb_data <= (rgbs == 1) ? 12'b000000000000 : 12'b111111111111;  
                3'b100 : rgb_data <= (rgbs == 1) ? 12'b111100000000 : 12'b111111111111;  
                3'b101 : rgb_data <= (rgbs == 1) ? 12'b000011110000 : 12'b111111111111;  
                3'b110 : rgb_data <= (rgbs == 1) ? 12'b000000001111 : 12'b111111111111;
            endcase
        end
        else if(red) begin
            rgb_data <= (rgbs == 1) ? 12'b111100000000 : 12'b111111111111;  
        end
        else if(blue) begin
            rgb_data <= (rgbs == 1) ? 12'b000000001111 : 12'b111111111111;  
        end
        else if(white) begin
            rgb_data <= (rgbs == 1) ? 12'b000000000000 : 12'b111111111111;  
        end
        else begin
            rgb_data <= (rgbs == 1) ? 12'b111111111111 : 12'b000000000000;  
        end
    end
    
endmodule













