`timescale 1ns / 1ps
`include "multiplier.v"

module multiplier_tb;

	reg [3:0] multiplier;
	reg [3:0] multiplicand;
	reg CLK;

	wire tx;
	wire [7:0] product;

	// Instantiate the Unit Under Test (UUT)
	booth_multiplier uut (
		.multiplier(multiplier), 
		.multiplicand(multiplicand), 
		.CLK(CLK),
		.tx(tx), 
		.product(product)
	);

	initial begin
		CLK = 0;
		forever #10 CLK = ~CLK;
	end

	initial begin
		$dumpfile("wave.vcd");
    	$dumpvars(0, multiplier_tb);
		
		multiplier = 4'b1111;	// -1
		multiplicand = 4'b1111;	// -1
		#410;

		multiplier = 4'b1111;	// -1
		multiplicand = 4'b0010;	// 2
		#410;
		
		$finish;	
	end
      
endmodule