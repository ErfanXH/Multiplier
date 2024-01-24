`timescale 1ns / 1ps
`include "multiplier.v"

module multiplier_tb;

	// Inputs
	reg [3:0] multiplier;
	reg [3:0] multiplicand;
	reg CLK;
	reg TCLK;
	reg rst;

	// Outputs
	wire tx;
	wire [7:0] product;

	// Instantiate the Unit Under Test (UUT)
	booth_multiplier uut (
		.multiplier(multiplier), 
		.multiplicand(multiplicand), 
		.CLK(CLK), 
		.TCLK(TCLK), 
		.rst(rst), 
		.tx(tx), 
		.product(product)
	);

	always begin
		#15;
		CLK = 0;
		#15;
		CLK = 1;
	end
	
	always begin
		#2;
		TCLK = 0;
		#2;
		TCLK = 1;
	end

	initial begin
		// Initialize Inputs
		rst = 1;
		multiplier = 0;
		multiplicand = 0;

		#10;
		rst = 0;
		#100;

		multiplier = 4'b0111;
		multiplicand = 4'b1110;

		#100;
        
		// Add stimulus here
		$finish;	
	end

	initial begin
		$monitor("Time: %b, Multiplier: %b, Multiplicand: %b, Product: %b, TX: %b", $time, multiplier, multiplicand, product, tx);
		#200;
		$finish;
	end
      
endmodule