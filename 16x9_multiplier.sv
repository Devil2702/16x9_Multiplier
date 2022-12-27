`timescale 1ns/10ps

module multiplier_16x9 (multiplier, multiplicand, product);
	input [15:0]multiplier;
	input [8:0]multiplicand;
	output [24:0]product;
	wire [24:0]product;

	assign product = multiplier * multiplicand;

endmodule

module multiplier_tb;
	bit [15:0]a;
	bit [8:0]b;
	bit [24:0]c;

	multiplier_16x9 I0(.multiplier(a),
										 .multiplicand(b),
									 	 .product(c)	 
										);

	initial begin
		a = 16'b0;
		b = 8'b0;

		#20ns;
		a = 16'b0110101101011000;
		b = 9'b010000111;

		#20ns;
		a = 16'b1010101011010000;
		b = 9'b010100110;

		#20ns;
		$finish;

	end

endmodule
