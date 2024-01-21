`timescale 1ns / 1ps

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
	main uut (
		.multiplier(multiplier), 
		.multiplicand(multiplicand), 
		.CLK(CLK), 
		.TCLK(TCLK), 
		.rst(rst), 
		.tx(tx), 
		.product(product)
	);

	always begin
		#15
		CLK = 0;
		#15
		CLK = 1;
	end
	
	always begin
		#2
		TCLK = 0;
		#2
		TCLK = 1;
	end

	initial begin
		// Initialize Inputs
		
		multiplier = 0;
		multiplicand = 0;
		rst = 1;

		#1
		
		rst = 0;
		multiplier = 4'b0111;
		multiplicand = 4'b1110;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule