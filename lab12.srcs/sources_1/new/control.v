`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2022 10:41:16 PM
// Design Name: 
// Module Name: control
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


module control(
    input [4:0]op,
    input [2:0]func3,
    input func7_5,
    output reg [2:0]ExtOP,
    output reg RegWr,
    output reg [2:0]Branch,
    output reg MemtoReg,
    output reg MemWr,
    output reg [2:0]MemOP,
    output reg ALUAsrc,
    output reg[1:0]ALUBsrc,
    output reg[3:0]ALUctr
    );
    
    always @ (*)begin
        case(op)
            5'b01101:begin 
                ExtOP = 3'b001;
                RegWr = 1;
                Branch = 3'b000;
                MemtoReg = 0;
                MemWr = 0;
                MemOP = 3'b000;
                ALUAsrc = 0;
                ALUBsrc = 2'b01;
                ALUctr = 4'b0011;
            end
            5'b00101:begin 
                ExtOP = 3'b001;
                RegWr = 1;
                Branch = 3'b000;
                MemtoReg = 0;
                MemWr = 0;
                MemOP = 3'b000;
                ALUAsrc = 1;
                ALUBsrc = 2'b01;
                ALUctr = 4'b0000;
            end
            5'b00100:begin 
                case(func3)
                    3'b000:begin
                        ExtOP = 3'b000;
                        RegWr = 1;
                        Branch = 3'b000;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b01;
                        ALUctr = 4'b0000;
                    end
                    3'b010:begin
                        ExtOP = 3'b000;
                        RegWr = 1;
                        Branch = 3'b000;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b01;
                        ALUctr = 4'b0010;
                    end
                    3'b011:begin
                        ExtOP = 3'b000;
                        RegWr = 1;
                        Branch = 3'b000;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b01;
                        ALUctr = 4'b1010;
                    end
                    3'b100:begin
                        ExtOP = 3'b000;
                        RegWr = 1;
                        Branch = 3'b000;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b01;
                        ALUctr = 4'b0100;
                    end
                    3'b110:begin
                        ExtOP = 3'b000;
                        RegWr = 1;
                        Branch = 3'b000;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b01;
                        ALUctr = 4'b0110;
                    end
                    3'b111:begin
                        ExtOP = 3'b000;
                        RegWr = 1;
                        Branch = 3'b000;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b01;
                        ALUctr = 4'b0111;
                    end
                    3'b001:begin
                        ExtOP = 3'b000;
                        RegWr = 1;
                        Branch = 3'b000;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b01;
                        ALUctr = 4'b0001;
                    end
                    3'b101:begin
                        ExtOP = 3'b000;
                        RegWr = 1;
                        Branch = 3'b000;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b01;
                        ALUctr = func7_5 ? 4'b1101 : 4'b0101;
                    end
                    default: begin
                        ExtOP = 3'b000;
                        RegWr = 0;
                        Branch = 3'b000;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b00;
                        ALUctr = 4'b0000;
                    end
                endcase 
            end
            5'b01100:begin 
                case(func3)
                    3'b000:begin
                        ExtOP = 3'b000;
                        RegWr = 1;
                        Branch = 3'b000;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b00;
                        ALUctr = func7_5 ? 4'b1000 : 4'b0000;
                    end
                    3'b001:begin
                        ExtOP = 3'b000;
                        RegWr = 1;
                        Branch = 3'b000;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b00;
                        ALUctr = 4'b0001;
                    end
                    3'b010:begin
                        ExtOP = 3'b000;
                        RegWr = 1;
                        Branch = 3'b000;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b00;
                        ALUctr = 4'b0010;
                    end
                    3'b011:begin
                        ExtOP = 3'b000;
                        RegWr = 1;
                        Branch = 3'b000;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b00;
                        ALUctr = 4'b1010;
                    end
                    3'b100:begin
                        ExtOP = 3'b000;
                        RegWr = 1;
                        Branch = 3'b000;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b00;
                        ALUctr = 4'b0100;
                    end
                    3'b101:begin
                        ExtOP = 3'b000;
                        RegWr = 1;
                        Branch = 3'b000;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b00;
                        ALUctr = func7_5 ? 4'b1101 : 4'b0101;
                    end
                    3'b110:begin
                        ExtOP = 3'b000;
                        RegWr = 1;
                        Branch = 3'b000;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b00;
                        ALUctr = 4'b0110;
                    end
                    3'b111:begin
                        ExtOP = 3'b000;
                        RegWr = 1;
                        Branch = 3'b000;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b00;
                        ALUctr = 4'b0111;
                    end
                    default:begin
                        ExtOP = 3'b000;
                        RegWr = 0;
                        Branch = 3'b000;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b00;
                        ALUctr = 4'b0000;
                    end
                endcase
            end
            5'b11011:begin 
                ExtOP = 3'b100;
                RegWr = 1;
                Branch = 3'b001;
                MemtoReg = 0;
                MemWr = 0;
                MemOP = 3'b000;
                ALUAsrc = 1;
                ALUBsrc = 2'b10;
                ALUctr = 4'b0000;
            end
            5'b11001:begin 
                ExtOP = 3'b000;
                RegWr = 1;
                Branch = 3'b010;
                MemtoReg = 0;
                MemWr = 0;
                MemOP = 3'b000;
                ALUAsrc = 1;
                ALUBsrc = 2'b10;
                ALUctr = 4'b0000;
            end
            5'b11000:begin 
                case(func3)
                    3'b000: begin
                        ExtOP = 3'b011;
                        RegWr = 0;
                        Branch = 3'b100;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b00;
                        ALUctr = 4'b0010;
                    end
                    3'b001: begin
                        ExtOP = 3'b011;
                        RegWr = 0;
                        Branch = 3'b101;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b00;
                        ALUctr = 4'b0010;
                    end
                    3'b100: begin
                        ExtOP = 3'b011;
                        RegWr = 0;
                        Branch = 3'b110;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b00;
                        ALUctr = 4'b0010;
                    end
                    3'b101: begin
                        ExtOP = 3'b011;
                        RegWr = 0;
                        Branch = 3'b111;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b00;
                        ALUctr = 4'b0010;
                    end
                    3'b110: begin
                        ExtOP = 3'b011;
                        RegWr = 0;
                        Branch = 3'b110;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b00;
                        ALUctr = 4'b1010;
                    end
                    3'b111: begin
                        ExtOP = 3'b011;
                        RegWr = 0;
                        Branch = 3'b111;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b00;
                        ALUctr = 4'b1010;
                    end
                    default:begin
                        ExtOP = 3'b000;
                        RegWr = 0;
                        Branch = 3'b000;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b00;
                        ALUctr = 4'b0000;
                    end
                endcase
            end
            5'b00000:begin 
                case(func3)
                    3'b000: begin
                        ExtOP = 3'b000;
                        RegWr = 1;
                        Branch = 3'b000;
                        MemtoReg = 1;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b01;
                        ALUctr = 4'b0000;
                    end
                    3'b001: begin
                        ExtOP = 3'b000;
                        RegWr = 1;
                        Branch = 3'b000;
                        MemtoReg = 1;
                        MemWr = 0;
                        MemOP = 3'b001;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b01;
                        ALUctr = 4'b0000;
                    end
                    3'b010: begin
                        ExtOP = 3'b000;
                        RegWr = 1;
                        Branch = 3'b000;
                        MemtoReg = 1;
                        MemWr = 0;
                        MemOP = 3'b010;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b01;
                        ALUctr = 4'b0000;
                    end
                    3'b100: begin
                        ExtOP = 3'b000;
                        RegWr = 1;
                        Branch = 3'b000;
                        MemtoReg = 1;
                        MemWr = 0;
                        MemOP = 3'b100;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b01;
                        ALUctr = 4'b0000;
                    end
                    3'b101: begin
                        ExtOP = 3'b000;
                        RegWr = 1;
                        Branch = 3'b000;
                        MemtoReg = 1;
                        MemWr = 0;
                        MemOP = 3'b101;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b01;
                        ALUctr = 4'b0000;
                    end
                    default:begin
                        ExtOP = 3'b000;
                        RegWr = 0;
                        Branch = 3'b000;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b00;
                        ALUctr = 4'b0000;
                    end
                endcase
            end
            5'b01000:begin
                case(func3)
                    3'b000: begin   
                        ExtOP = 3'b010;
                        RegWr = 0;
                        Branch = 3'b000;
                        MemtoReg = 0;
                        MemWr = 1;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b01;
                        ALUctr = 4'b0000;
                    end
                    3'b001: begin   
                        ExtOP = 3'b010;
                        RegWr = 0;
                        Branch = 3'b000;
                        MemtoReg = 0;
                        MemWr = 1;
                        MemOP = 3'b001;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b01;
                        ALUctr = 4'b0000;
                    end
                    3'b010: begin   
                        ExtOP = 3'b010;
                        RegWr = 0;
                        Branch = 3'b000;
                        MemtoReg = 0;
                        MemWr = 1;
                        MemOP = 3'b010;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b01;
                        ALUctr = 4'b0000;
                    end
                    default:begin
                        ExtOP = 3'b000;
                        RegWr = 0;
                        Branch = 3'b000;
                        MemtoReg = 0;
                        MemWr = 0;
                        MemOP = 3'b000;
                        ALUAsrc = 0;
                        ALUBsrc = 2'b00;
                        ALUctr = 4'b0000;
                    end
                endcase 
            end
            default:begin
                ExtOP = 3'b000;
                RegWr = 0;
                Branch = 3'b000;
                MemtoReg = 0;
                MemWr = 0;
                MemOP = 3'b000;
                ALUAsrc = 0;
                ALUBsrc = 2'b00;
                ALUctr = 4'b0000;
            end
        endcase
    end
endmodule





