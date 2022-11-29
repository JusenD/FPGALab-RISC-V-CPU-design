`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2022 04:38:15 PM
// Design Name: 
// Module Name: test_cpu
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


module test_cpu();

integer numcycles;  //number of cycles in test

reg clk,reset;  //clk and reset signals

reg[8*15:1] testcase; //name of testcase

wire [31:0]idataout;
mainDesign try(.clk(clk), .reset(reset), .dbgout(idataout));

//useful tasks
task step;  //step for one cycle ends 1ns AFTER the posedge of the next cycle
	begin
		#9  clk=1'b0; 
		#10 clk=1'b1;
		numcycles = numcycles + 1;	
		#1 ;
	end
endtask

task stepn; //step n cycles
   input integer n; 
	integer i;
	begin
		for (i =0; i<n ; i=i+1)
			step();
	end
endtask

task loadtestcase;  //load intstructions to instruction mem
	begin
		$readmemh({"D:/Xilinx/Project/lab11/lab11.sim/sim_1/behav/sim/",testcase, ".hex"},try.instructions.ram);
		$display("~~~ Begin test case %s ~~~", testcase);
	end
endtask

task resetcpu;  //reset the CPU and the test
	begin
		reset = 1'b1; 
		step();
		#5 reset = 1'b0;
		numcycles = 0;
	end
endtask

integer maxcycles =10000;

task run;
   integer i;
	begin
	   i = 0;
	   while((idataout!=32'hdead10cc) && (i<maxcycles))
		begin
		   step();
			i=i+1;
		end
	end
endtask

task checkmagnum;
    begin
	    if(numcycles>=maxcycles)
		 begin
		   $display("~~~ Error:test case %s does not terminate!", testcase);
		 end
		 else if(try.mycpu.myregfile.regs[10]==32'hc0ffee)
		    begin
		       $display("~~~ OK:test case %s finshed OK at cycle %3d.", testcase, numcycles-1);
		    end
		 else if(try.mycpu.myregfile.regs[10]==32'hdeaddead)
		 begin
		   $display("~~~ ERROR:test case %s finshed with error in cycle %3d.", testcase, numcycles-1);
		 end
		 else
		 begin
		    $display("~~~ ERROR:test case %s unknown error in cycle %3d.", testcase, numcycles-1);
		 end
	 end
endtask

task loaddatamem;
    begin
	     $readmemh({"D:/Xilinx/Project/lab11/lab11.sim/sim_1/behav/sim/",testcase, "_d.hex"},try.datamem.mymem.ram);
	 end
endtask

task run_riscv_test;
    begin
	   loadtestcase();
		loaddatamem();
		resetcpu();
		run();
		checkmagnum();
	 end
endtask
	
initial begin:TestBench
      #80
      // output the state of every instruction
testcase = "rv32ui-p-simple";
		run_riscv_test();
		testcase = "rv32ui-p-add";
		run_riscv_test();
		testcase = "rv32ui-p-addi";
		run_riscv_test();
		testcase = "rv32ui-p-and";
		run_riscv_test();
		testcase = "rv32ui-p-andi";
		run_riscv_test();
	   testcase = "rv32ui-p-auipc";
		run_riscv_test();
		testcase = "rv32ui-p-beq";
		run_riscv_test();
		testcase = "rv32ui-p-bge";
		run_riscv_test();
		testcase = "rv32ui-p-bgeu";
		run_riscv_test();
		testcase = "rv32ui-p-blt";
		run_riscv_test();
		testcase = "rv32ui-p-bltu";
		run_riscv_test();
		testcase = "rv32ui-p-bne";
		run_riscv_test();
		testcase = "rv32ui-p-jal";
		run_riscv_test();
		testcase = "rv32ui-p-jalr";
		run_riscv_test();
		testcase = "rv32ui-p-lb";
		run_riscv_test();
		testcase = "rv32ui-p-lbu";
		run_riscv_test();
		testcase = "rv32ui-p-lh";
		run_riscv_test();
		testcase = "rv32ui-p-lhu";
		run_riscv_test();
		testcase = "rv32ui-p-lui";
		run_riscv_test();
		testcase = "rv32ui-p-lw";
		run_riscv_test();
		testcase = "rv32ui-p-or";
		run_riscv_test();
		testcase = "rv32ui-p-ori";
		run_riscv_test();
		testcase = "rv32ui-p-sb";
		run_riscv_test();
		testcase = "rv32ui-p-sh";
		run_riscv_test();
		testcase = "rv32ui-p-sll";
		run_riscv_test();
		testcase = "rv32ui-p-slli";
		run_riscv_test();
		testcase = "rv32ui-p-slt";
		run_riscv_test();
		testcase = "rv32ui-p-slti";
		run_riscv_test();
		testcase = "rv32ui-p-sltiu";
		run_riscv_test();
		testcase = "rv32ui-p-sltu";
		run_riscv_test();
		testcase = "rv32ui-p-sra";
		run_riscv_test();
		testcase = "rv32ui-p-srai";
		run_riscv_test();
		testcase = "rv32ui-p-srl";
		run_riscv_test();
		testcase = "rv32ui-p-srli";
		run_riscv_test();
		testcase = "rv32ui-p-sub";
		run_riscv_test();
		testcase = "rv32ui-p-sw";
		run_riscv_test();
		testcase = "rv32ui-p-xor";
		run_riscv_test();
		testcase = "rv32ui-p-xori";
		run_riscv_test();	
		$stop;
		
end

endmodule
