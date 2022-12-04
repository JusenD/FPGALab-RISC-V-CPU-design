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
        $readmemh("D:/Xilinx/Project/lab12/FPGALab-RISC-V-CPU-design/software/main.hex",ram);
    end
	
	always@(posedge clock)
		q <= ram[address];
		
endmodule