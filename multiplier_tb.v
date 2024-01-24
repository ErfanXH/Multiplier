`timescale 1ns / 1ps
`include "multiplier.v"

module multiplier_tb;

	// Inputs
	reg [3:0] multiplier;
	reg [3:0] multiplicand;
	reg CLK;
	reg TCLK;

	// Outputs
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
		$dumpfile("waveform.vcd");
    	$dumpvars(0, multiplier_tb);
		
		product 
		multiplier = 4'b0111;	// 7
		multiplicand = 4'b1110;	// -2
		#800;

		multiplier = 4'b1111;	// -1
		multiplicand = 4'b0010;	// 2
		#800;
        
		// Add stimulus here
		$finish;	
	end

	// initial begin
	// 	$monitor("Time: %b, Multiplier: %b, Multiplicand: %b, Product: %b, TX: %b", $time, multiplier, multiplicand, product, tx);
	// 	#200;
	// 	$finish;
	// end
      
endmodule