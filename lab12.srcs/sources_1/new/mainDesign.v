`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2022 03:30:09 PM
// Design Name: 
// Module Name: mainDesign
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


module mainDesign(
    input CLK100MHZ,
    input clk,
    input reset,
    output reg[7:0]AN,
    output reg[7:0]HEX
    );
    
// CPU declaration

// signals
wire [31:0] iaddr,idataout;
wire iclk;
wire [31:0] daddr,ddataout,ddatain;
wire [31:0] ddata;
wire datawe;
wire drdclk, dwrclk, dwe;
wire [2:0]  dop;
wire [31:0] cpudbgdata;
wire [31:0] keymemout;
assign dbgout = idataout;

//main CPU
rv32is mycpu(.clock(clk), 
             .reset(reset), 
             .imemaddr(iaddr), .imemdataout(idataout), .imemclk(iclk), 
             .dmemaddr(daddr), .dmemdataout(ddataout), .dmemdatain(ddatain), .dmemrdclk(drdclk), .dmemwrclk(dwrclk), .dmemop(dop), .dmemwe(dwe), 
             .dbgdata(cpudbgdata));

				  
//instruction memory, no writing
testmem instructions(
	.address(iaddr[17:2]),
	.clock(iclk),
	.data(32'b0),
	.wren(1'b0),
	.q(idataout));
	

//data memory	

assign datawe = daddr[31:20] == 12'h001 & dwe;
assign ddata = (daddr[31:20] == 12'h001) ? ddataout :
                ((daddr[31:20] == 12'h003) ? keymemout : 32'b0);

dmem datamem(.addr(daddr), 
             .dataout(ddataout), 
             .datain(ddatain), 
             .rdclk(drdclk), 
             .wrclk(dwrclk), 
             .memop(dop), 
             .we(datawe));
    
    
//display debugdata
wire display_clk;
clkgen #(1000) DISPLAY_CLK (CLK100MHZ, 1'b0, 1'b1, display_clk);
reg [2:0]cnt = 0;
always @ (posedge display_clk)begin
    cnt <= cnt + 1;
end
wire [63:0]segdata;
bcd7seg i1(cpudbgdata[31:28], segdata[63:56]);
bcd7seg i2(cpudbgdata[27:24], segdata[55:48]);
bcd7seg i3(cpudbgdata[23:20], segdata[47:40]);
bcd7seg i4(cpudbgdata[19:16], segdata[39:32]);
bcd7seg i5(cpudbgdata[15:12], segdata[31:24]);
bcd7seg i6(cpudbgdata[11:8], segdata[23:16]);
bcd7seg i7(cpudbgdata[7:4], segdata[15:8]);
bcd7seg i8(cpudbgdata[3:0], segdata[7:0]);
always @ (*)begin
    case(cnt)
        3'd0:begin AN = 8'b11111110; HEX = segdata[7:0]; end
        3'd1:begin AN = 8'b11111101; HEX = segdata[15:8]; end
        3'd2:begin AN = 8'b11111011; HEX = segdata[23:16]; end
        3'd3:begin AN = 8'b11110111; HEX = segdata[31:24]; end
        3'd4:begin AN = 8'b11101111; HEX = segdata[39:32]; end
        3'd5:begin AN = 8'b11011111; HEX = segdata[47:40]; end
        3'd6:begin AN = 8'b10111111; HEX = segdata[55:48]; end
        3'd7:begin AN = 8'b01111111; HEX = segdata[63:56]; end
        default: begin AN = 0; HEX = 0; end
    endcase
end
    
endmodule











