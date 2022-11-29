module testmem(
	address,
	clock,
	data,
	wren,
	q);

	input	[15:0]  address;
	input	  clock;
	input	[31:0]  data;
	input	  wren;
	output reg	[31:0]  q;
	
	reg [31:0] ram [65535:0];
	
	initial begin
        $readmemh("D:/Xilinx/Project/lab11/lab11.sim/sim_1/behav/sim/rv32ui-p-lh.hex",ram);
    end
	
	always@(posedge clock)
		q <= ram[address];
		
endmodule