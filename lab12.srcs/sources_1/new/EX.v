`include "macro.v"
/*    EX level2(
        input clk, busA, busB, control, reset
        output result, control
        );*/

module EX(
    input clk,
    input [31:0]ID_busA,
    input [31:0]ID_busB,
    input [18:0]ID_control,
    input [31:0]ID_PC,
    input [4:0]ID_rd,
    input [31:0]ID_imm,
    input reset,
    input ID_valid,
    input bubble,
    output [31:0]Result,
    output reg[31:0]EX_Result,
    output reg[31:0]EX_nextPC,
    output reg[18:0]EX_control,
    output reg[31:0]EX_busB,
    output reg[4:0]EX_rd,
    output reg pre_fail,
    output reg EX_valid
    );
    
    reg [31:0]EX_PC;
    wire [31:0]PC = EX_PC;
    wire [31:0]busA = ID_busA, busB = ID_busB, imm = ID_imm;
    wire[31:0] NextPC, PCA, PCB;
    wire Less, Zero;
    reg PCAsrc, PCBsrc;
    reg [31:0]ALUB;
    // ALU 
    wire [31:0]ALUA = ID_control[`ALUAsrc] ? PC : busA;
    always @ (*)begin
        case(ID_control[`ALUBsrc])
            2'b00: ALUB = busB;
            2'b01: ALUB = imm;
            2'b10: ALUB = 32'd4;
        endcase 
    end
    ALU myALU(ALUA, ALUB, ID_control[`ALUctr], Less, Zero, Result);
    
    // jump 
    always @ (*)begin
        case(ID_control[`Branch])
            3'b000: begin
                PCAsrc = 0;
                PCBsrc = 0;
            end
            3'b001: begin
                PCAsrc = 1;
                PCBsrc = 0;
            end
            3'b010: begin
                PCAsrc = 1;
                PCBsrc = 1;
            end
            3'b100: begin
                PCAsrc = Zero;
                PCBsrc = 0;
            end
            3'b101: begin
                PCAsrc = ~Zero;
                PCBsrc = 0;
            end
            3'b110: begin
                PCAsrc = Less;
                PCBsrc = 0;
            end
            3'b111: begin
                PCAsrc = ~Less;
                PCBsrc = 0;
            end
            default:begin
                PCAsrc = 0;
                PCBsrc = 0;
            end
        endcase 
    end
    assign PCA = PCAsrc ? imm : 32'd4;
    assign PCB = PCBsrc ? busA : PC;
    assign NextPC = reset ? 0 : PCA+PCB;
    reg [1:0]cnt = 1;
    reg check;
    always @ (posedge clk) begin
        if(bubble) check <= 0;
        if(check == 0) check <= 1;
        if(reset)begin
            EX_Result <= 0;
            EX_PC <= 0;
            EX_nextPC <= 0;
            EX_control <= 0;
            EX_busB <= 0;
            EX_rd <= 0;
            pre_fail <= 0;
            cnt <= 1;
            check <= 1;
        end
        else if(cnt != 3)begin
            pre_fail <= 0;
            EX_PC <= ID_PC;
            cnt <= cnt + 1;
        end
        else if(~ID_valid)begin
            EX_valid <= 0;
        end
/*        else if(pre_fail) begin
            if(cnt==2) pre_fail <= 0;
            else cnt <= cnt+1;
        end*/
        else begin
            check <= 1;
            EX_valid <= 1;
            EX_Result <= Result;
            EX_PC <= ID_PC;
            EX_nextPC <= NextPC;
            EX_control <= ID_control;
            EX_busB <= busB;
            EX_rd <= ID_rd;
            pre_fail <= NextPC != EX_PC + 4;
            cnt <= (NextPC != EX_PC + 4) ? 0 : 3;
        end
    end
    
endmodule













