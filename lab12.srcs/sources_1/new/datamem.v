`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2022 06:59:30 PM
// Design Name: 
// Module Name: datamem
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


module datamem(addr, dataout, datain, rdclk, wrclk, memop, we);
	input  [31:0] addr;
	output reg [31:0] dataout;
	input  [31:0] datain;
	input  rdclk;
	input  wrclk;
	input [2:0] memop;
	input we;
	
	wire [31:0]data;
    wire [31:0] memin;
    reg [3:0] which;
    assign memin = (memop[1:0]==2'b00)?{4{datain[7:0]}}:((memop[1:0]==2'b10)?datain:{2{datain[15:0]}}) ; //lb: same for all four, lh:copy twice; lw:copy
    dRAM RAM(.addra(addr[16:2]), .clka(wrclk), .dina(memin), .ena(1'b1), .wea(we ? which : 4'b0),
             .addrb(addr[16:2]), .clkb(rdclk), .doutb(data), .enb(1'b1));
    
    always @ (*) begin
        case(memop[1:0])
            2'b00: begin 
                case(addr[1:0])
                    2'b00: dataout = {{24{memop[2] ? 1'b0 : data[7]}} , data[7:0]};
                    2'b01: dataout = {{24{memop[2] ? 1'b0 : data[15]}} , data[15:8]};
                    2'b10: dataout = {{24{memop[2] ? 1'b0 : data[23]}} , data[23:16]};
                    2'b11: dataout = {{24{memop[2] ? 1'b0 : data[31]}} , data[31:24]};
                endcase 
            end
            2'b01: begin 
                case(addr[1:0])
                    2'b00: dataout = {{16{memop[2] ? 1'b0 : data[15]}} , data[15:0]};
                    2'b10: dataout = {{16{memop[2] ? 1'b0 : data[31]}} , data[31:16]};
                endcase 
            end
            2'b10: begin 
                dataout = data;
            end
            default dataout = data;
        endcase
    end
	
	// write which
	always @ (*)begin
	   case(memop)
	       3'b000: begin
	           case(addr[1:0])
	               2'b00: which = 4'b0001;
	               2'b01: which = 4'b0010;
	               2'b10: which = 4'b0100;
	               2'b11: which = 4'b1000;
	               default: which = 0;
               endcase 
	       end
	       3'b001: begin
	           case(addr[1:0])
	               2'b00: which = 4'b0011;
	               2'b10: which = 4'b1100;
	               default: which = 0;
               endcase 
	       end
	       3'b010: begin
	           which = 4'b1111;
	       end
	       default: which = 0;
	   endcase 
	end
	
endmodule
