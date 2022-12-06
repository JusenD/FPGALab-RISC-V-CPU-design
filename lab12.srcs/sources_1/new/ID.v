`include "macro.v"
/*    ID level1(
        input clk, instr, rega, regb, reset
        output imm, rs1, rs2, rd, control, busA, busB
        );*/
module ID(
    input clk,
    input [31:0]instruction,
    input [31:0]rega,
    input [31:0]regb,
    input [31:0]IF_PC,
    input reset,
    input [4:0]MEM_rd,
    input [31:0]EX_Result,
    input [31:0]MEM_Result,
    input [18:0]MEM_control,
    input EX_valid,
    input MEM_valid,
    output reg[31:0]ID_imm,
    output [4:0]rs1,
    output [4:0]rs2,
    output reg[4:0]ID_rd,
    output reg[18:0]control_signal,
    output reg[31:0]busA,
    output reg[31:0]busB,
    output reg[31:0]ID_PC,
    output reg bubble,
    output reg ID_valid
    );
    reg [31:0] last_instr;
    wire [31:0]instr = reset ? 0 : ((former | bubble) ? last_instr : instruction);
    reg load, former;
    reg [4:0]load_reg;
    wire [18:0]EX_control = control_signal;
    // instr decode
    wire [6:0]op = instr[6:0];
    assign rs1 = instr[19:15];
    assign rs2 = instr[24:20];
    wire [4:0]rd = instr[11:7];
    wire [4:0]EX_rd = ID_rd;
    wire [2:0]func3 = instr[14:12];
    wire [6:0]func7 = instr[31:25];
    
    // imm generate
    reg[31:0]imm;
    wire [31:0]immI = {{20{instr[31]}}, instr[31:20]};
    wire [31:0]immU = {instr[31:12], 12'b0};
    wire [31:0]immS = {{20{instr[31]}}, instr[31:25], instr[11:7]};
    wire [31:0]immB = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
    wire [31:0]immJ = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
    always @(*) begin
        case(control_buffer[`ExtOP])
            3'b000: imm = immI;
            3'b001: imm = immU;
            3'b010: imm = immS;
            3'b011: imm = immB;
            3'b100: imm = immJ;
            default: imm = 0;
        endcase 
    end
    
    // control 
    wire [18:0] control_buffer;
    control CONTROL(op[6:2], func3, func7[5], control_buffer[`ExtOP], control_buffer[`RegWr], control_buffer[`Branch], control_buffer[`MemtoReg], control_buffer[`MemWr], control_buffer[`MemOP], control_buffer[`ALUAsrc], control_buffer[`ALUBsrc], control_buffer[`ALUctr]);
    
    always @ (posedge clk)begin 
        if(reset)begin
            control_signal <= 0;
            ID_rd <= 0;
            busA <= 0;
            busB <= 0;
            ID_PC <= 0;
            bubble <= 0;
            load <= 0;
            last_instr <= 0;
            former <= 0;
            ID_valid <= 0;
        end
        else if(bubble) begin
            former <= 1;
            bubble <= 0;
            ID_valid <= 1;
            control_signal <= control_buffer;
            ID_rd <= rd;
            ID_imm <= imm;
            load <= ((op[6:2] == 0) && (instr != 32'b0));
            load_reg <= rd;
            last_instr <= instruction;
            ID_PC <= ID_PC + 4;
            // rs1 hazard
            if(EX_valid && rs1 == MEM_rd && MEM_control[`RegWr])begin
                busA <= rs1 == 0 ? 0 : MEM_Result;
            end
            else busA <= rega;
            // rs2 hazard 
            if(EX_valid && rs2 == MEM_rd && MEM_control[`RegWr])begin
                busB <= rs2 == 0 ? 0 : MEM_Result;
            end
            else busB <= regb;
        end
        else begin
            if(~(load && (rs1 == load_reg || rs2 == load_reg) && EX_control[`RegWr])) ID_PC <= IF_PC;
            control_signal <= control_buffer;
            ID_rd <= rd;
            ID_imm <= imm;
            load <= op[6:2] == 0 && (instr != 32'b0);
            load_reg <= rd;
            last_instr <= instr;
            // load-use
            ID_valid <= ~(load && (rs1 == load_reg || rs2 == load_reg) && EX_control[`RegWr]);
            bubble <= (load && (rs1 == load_reg || rs2 == load_reg) && EX_control[`RegWr]);
            // rs1 hazard
            if(ID_valid && rs1 == EX_rd && EX_control[`RegWr])begin
                busA <= rs1 == 0 ? 0 : EX_Result;
            end
            else if(EX_valid && rs1 == MEM_rd && MEM_control[`RegWr])begin
                busA <= rs1 == 0 ? 0 : MEM_Result;
            end
            else busA <= rega;
            // rs2 hazard 
            if(ID_valid && rs2 == EX_rd && EX_control[`RegWr])begin
                    busB <= rs2 == 0 ? 0 : EX_Result;
            end
            else if(EX_valid && rs2 == MEM_rd && MEM_control[`RegWr])begin
                busB <= rs2 == 0 ? 0 : MEM_Result;
            end
            else busB <= regb;
        end
        if(former) former <= 0;
    end
    
endmodule











