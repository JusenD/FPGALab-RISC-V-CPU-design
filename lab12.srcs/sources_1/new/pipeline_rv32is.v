`include "macro.v"
module pipeline_rv32is(
    input 	clock,
	input 	reset,
	output [31:0] imemaddr,
	input  [31:0] imemdataout,
	output 	imemclk,
	output [31:0] dmemaddr,
	input  [31:0] dmemdataout,
	output [31:0] dmemdatain,
	output 	dmemrdclk,
	output	dmemwrclk,
	output [2:0] dmemop,
	output	dmemwe,
	output MemtoReg,
	output [31:0] dbgdata
    );
    
    assign dbgdata = IF_PC;
//////// IF instruction fetch ///////////
    wire [31:0]instr, IF_PC, IF_pre_PC;
    wire pre_fail, bubble;
    
    reg pc_branch = 0; reg [1:0]cnt = 0;
    always @ (posedge clock) begin
        if(pre_fail) begin 
            pc_branch <= 1;
            cnt <= 4;
        end
        else if(cnt == 0) pc_branch <= 0;
        else cnt <= cnt-1;
    end
    
    
    assign imemclk = clock;
    IF level0(.clk(clock), .nextPC(EX_nextPC), .pre_fail(pre_fail), .bubble(bubble), .former_PC(EX_PC),
              .imemdataout(imemdataout), .reset(reset), .instr(instr), .imemaddr(imemaddr), .IF_PC(IF_PC), .IF_pre_PC(IF_pre_PC));
    
//////// ID instruction decode /////////
    
    wire [18:0]ID_control;
    wire [4:0]ID_rs1, ID_rs2, ID_rd;
    wire [31:0]ID_busA, ID_busB, ID_imm, ID_PC, ID_pre_PC;
    wire ID_valid;
       ID level1(.clk(clock), .instruction(instr), .rega(busA), .regb(busB), .IF_PC_buffer(IF_PC), .IF_pre_PC_buffer(IF_pre_PC), .ID_PC(ID_PC), .ID_pre_PC(ID_pre_PC),.reset(reset | pre_fail),
                 .EX_rd(EX_rd), .EX_Result(EX_Result), .MEM_rd(MEM_rd), .MEM_Result(MEM_busW), .MEM_control(MEM_control), .EX_valid(EX_valid), .MEM_valid(MEM_valid),
                 .ID_imm(ID_imm), .rs1(ID_rs1), .rs2(ID_rs2), .ID_rd(ID_rd), .control_signal(ID_control), .busA(ID_busA), .busB(ID_busB),
                 .bubble(bubble), .ID_valid(ID_valid));
    
///////// EX execute ///////////////////
    wire [31:0]EX_Result, EX_nextPC, EX_busB, EX_ALU_result, EX_PC;
    wire [4:0]EX_rd;
    wire [18:0] EX_control;
    wire EX_valid;
    EX level2(.clk(clock), .ID_busA(ID_busA), .ID_busB(ID_busB), .ID_control(ID_control), .reset(reset), .ID_rd(ID_rd), .ID_imm(ID_imm), .ID_PC(ID_PC), .ID_valid(ID_valid), .bubble(bubble), .ID_pre_PC(ID_pre_PC),
              .Result(EX_ALU_result), .EX_Result(EX_Result), .EX_PC(EX_PC), .EX_nextPC(EX_nextPC), .EX_control(EX_control), .EX_busB(EX_busB), .EX_rd(EX_rd), .pre_fail(pre_fail), .EX_valid(EX_valid));
    
///////// MEM memory ////////////////////
    wire [31:0]MEM_Result, MEM_busB, MEM_busW, MEM_temp;
    wire [4:0]MEM_rd;
    wire [18:0]MEM_control;
    wire MEM_valid;
    assign dmemaddr = EX_Result;
    assign dmemop = EX_control[`MemOP];
    assign dmemdatain = EX_busB;
    assign dmemwe = EX_control[`MemWr];
    assign dmemrdclk = ~clock;
    assign dmemwrclk = clock;
    assign MemtoReg = EX_control[`MemtoReg];
    MEM level3(.clk(clock), .EX_Result(EX_Result), .EX_busB(EX_busB), .EX_control(EX_control), .dmemdataout(dmemdataout), .reset(reset), .EX_rd(EX_rd), .EX_valid(EX_valid),
               .MEM_Result(MEM_Result), .MEM_busB(MEM_busB), .MEM_busW(MEM_busW), .MEM_control(MEM_control), .MEM_rd(MEM_rd), .MEM_valid(MEM_valid), .MEM_temp(MEM_temp));
    
//////// WB write back//////////////////
    wire [31:0]WB_regwritedata;
    wire [4:0]WB_rd;
    wire [18:0]WB_control;
    wire WB_valid;
    WB level4(.clk(clock), .MEM_busW(MEM_busW), .MEM_rd(MEM_rd), .MEM_control(MEM_control), .reset(reset), .MEM_valid(MEM_valid), .WB_valid(WB_valid),
              .WB_rd(WB_rd), .WB_regwritedata(WB_regwritedata), .WB_control(WB_control));
    
    // regs 
    wire [31:0]busA, busB;
    GPRS myregfile(~clock, WB_control[`RegWr] & WB_valid, ID_rs1, ID_rs2, WB_rd, WB_regwritedata, busA, busB);
    
endmodule














