// 16bits multiplier , 1bit multiplicand , 16bit product
module partial_product_generator(multiplier,multiplicand,product);
	input	[15:0]multiplier;
	input multiplicand;
	output [15:0]product;

	reg [15:0]product;

	always@(*)begin
			if(multiplicand == 0)
				product = 0;
			else 
				product = multiplier;
	end

endmodule

// 16-bit multiplier , 16-bit multiplicand , 16-bit product
module pp_gen(g_multiplier,g_multiplicand,g_product);
	input  [15:0]g_multiplier;
	input   [8:0]g_multiplicand;
	output [15:0]g_product[8:0];

	genvar i;

	generate 
		for(i =0; i<9; i++)begin
				partial_product_generator p0(.multiplier(g_multiplier),
																		 .multiplicand(g_multiplicand[i]),
																		 .product(g_product[i]));
		end
	endgenerate


endmodule
