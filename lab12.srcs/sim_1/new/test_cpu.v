`timescale 1ns / 1ps
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

module ps2_keyboard_model(
 output reg ps2_clk,
 output reg ps2_data
 );
 parameter [31:0] kbd_clk_period = 60;
 initial ps2_clk = 1'b1;

 task kbd_sendcode;
 input [7:0] code; // key to be sent
 integer i;

 reg[10:0] send_buffer;
 begin
 send_buffer[0] = 1'b0; // start bit
 send_buffer[8:1] = code; // code
 send_buffer[9] = ~(^code); // odd parity bit
 send_buffer[10] = 1'b1; // stop bit
 i = 0;
 while( i < 11) begin
 // set kbd_data
 ps2_data = send_buffer[i];
 #(kbd_clk_period/2) ps2_clk = 1'b0;
 #(kbd_clk_period/2) ps2_clk = 1'b1;
 i = i + 1;
 end
 end
 endtask

 endmodule


module test_cpu();

integer numcycles;  //number of cycles in test

reg clk,reset = 0;  //clk and reset signals

reg[8*15:1] testcase; //name of testcase

wire [31:0]idataout;


// keyboard 
/* parameter */
 parameter [31:0] clock_period = 10;

 /* ps2_keyboard interface signals */
 reg clkp,clrn;
 wire [7:0] data;
 wire ready,overflow;
 wire kbd_clk, kbd_data;
 reg nextdata_n;

 ps2_keyboard_model model(
 .ps2_clk(kbd_clk),
 .ps2_data(kbd_data)
 );


 initial begin /* clock driver */
 clkp = 0;
 forever
 #(clock_period/2) clkp = ~clkp;
 end


mainDesign try(.clk(clk), .reset(reset), .PS2_CLK(kbd_clk), .PS2_DATA(kbd_data), .CLK100MHZ(clkp), .dbgout(idataout));

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
         reset = 1'b1; #20;
         reset = 1'b0; #20;
         model.kbd_sendcode(8'h1C); // press 'A'
         #20 nextdata_n =1'b0; #20 nextdata_n =1'b1;//read data
         model.kbd_sendcode(8'hF0); // break code
         #20 nextdata_n =1'b0; #20 nextdata_n =1'b1; //read data
         model.kbd_sendcode(8'h1C); // release 'A'
         #20 nextdata_n =1'b0; #20 nextdata_n =1'b1; //read data
         model.kbd_sendcode(8'h1B); // press 'S'
         #20 model.kbd_sendcode(8'h1B); // keep pressing 'S'
         #20 model.kbd_sendcode(8'h1B); // keep pressing 'S'
         model.kbd_sendcode(8'hF0); // break code
         model.kbd_sendcode(8'h1B); // release 'S'
         #20;
		testcase = "rv32ui-p-main";
		run_riscv_test();
		testcase = "rv32ui-p-addi";
//		run_riscv_test();
//		testcase = "rv32ui-p-and";
//		run_riscv_test();
//		testcase = "rv32ui-p-andi";
//		run_riscv_test();
//	   testcase = "rv32ui-p-auipc";
//		run_riscv_test();
//		testcase = "rv32ui-p-beq";
//		run_riscv_test();
//		testcase = "rv32ui-p-bge";
//		run_riscv_test();
//		testcase = "rv32ui-p-bgeu";
//		run_riscv_test();
//		testcase = "rv32ui-p-blt";
//		run_riscv_test();
//		testcase = "rv32ui-p-bltu";
//		run_riscv_test();
//		testcase = "rv32ui-p-bne";
//		run_riscv_test();
//		testcase = "rv32ui-p-jal";
//		run_riscv_test();
//		testcase = "rv32ui-p-jalr";
//		run_riscv_test();
//		testcase = "rv32ui-p-lb";
//		run_riscv_test();
//		testcase = "rv32ui-p-lbu";
//		run_riscv_test();
//		testcase = "rv32ui-p-lh";
//		run_riscv_test();
//		testcase = "rv32ui-p-lhu";
//		run_riscv_test();
//		testcase = "rv32ui-p-lui";
//		run_riscv_test();
//		testcase = "rv32ui-p-lw";
//		run_riscv_test();
//		testcase = "rv32ui-p-or";
//		run_riscv_test();
//		testcase = "rv32ui-p-ori";
//		run_riscv_test();
//		testcase = "rv32ui-p-sb";
//		run_riscv_test();
//		testcase = "rv32ui-p-sh";
//		run_riscv_test();
//		testcase = "rv32ui-p-sll";
//		run_riscv_test();
//		testcase = "rv32ui-p-slli";
//		run_riscv_test();
//		testcase = "rv32ui-p-slt";
//		run_riscv_test();
//		testcase = "rv32ui-p-slti";
//		run_riscv_test();
//		testcase = "rv32ui-p-sltiu";
//		run_riscv_test();
//		testcase = "rv32ui-p-sltu";
//		run_riscv_test();
//		testcase = "rv32ui-p-sra";
//		run_riscv_test();
//		testcase = "rv32ui-p-srai";
//		run_riscv_test();
//		testcase = "rv32ui-p-srl";
//		run_riscv_test();
//		testcase = "rv32ui-p-srli";
//		run_riscv_test();
//		testcase = "rv32ui-p-sub";
//		run_riscv_test();
//		testcase = "rv32ui-p-sw";
//		run_riscv_test();
//		testcase = "rv32ui-p-xor";
//		run_riscv_test();
//		testcase = "rv32ui-p-xori";
//		run_riscv_test();	
		$stop;
end		

endmodule