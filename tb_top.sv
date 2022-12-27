`timescale 1ns/1ps
`include "partial_product_generator.sv"
`include "carry_save_adder.sv"
`include "carry_propagate_adder.sv"

// DUT 
module dut_top(multiplier, multiplicand, final_product);

	input [15:0]multiplier;
	input [8:0]multiplicand;
	output [24:0]final_product;
	reg [24:0]final_product;
	
	// wire connections which are connecting to different modules
	
	wire [15:0]g_product_net[8:0];
	wire [23:0]sum_net;
	wire [24:0]carry_net;

	//partial_product_generate instantiation
	pp_gen I0(.g_multiplier(multiplier),
						.g_multiplicand(multiplicand),
						.g_product(g_product_net)
						);
	//carry_save_adder instantiation
	carry_save_adder CSA0(.p0(g_product_net[0]),.p1(g_product_net[1]),.p2(g_product_net[2]),.p3(g_product_net[3]),
												.p4(g_product_net[4]),.p5(g_product_net[5]),.p6(g_product_net[6]),.p7(g_product_net[7]),
												.p8(g_product_net[8]),.sum(sum_net),.carry_out(carry_net));
					
	//carry_propagate_adder instantiation
	carry_propagate_adder CPA0(.X(sum_net),.Y(carry_net),.final_sum(final_product));


endmodule

module tb_top;

	bit [15:0]multiplier;
	bit [8:0]multiplicand;
	bit [24:0]product;
	
	// 16x9_multiplier DUT 
	dut_top DUT(.multiplier(multiplier), .multiplicand(multiplicand), .final_product(product));

	initial begin
		multiplier = 0;
		multiplicand = 0;

		#20ns;

		multiplier = 16'b0110101101011000;
		multiplicand = 9'b010000111;

		#20ns;

		multiplier = 16'b0010111001010011;
		multiplicand = 9'b110100011;

		#20ns;

	end

	initial begin
		$monitor("multiplier -- %h multiplicand -- %h product -- %h",multiplier, multiplicand, product);

		$dumpfile("top.vcd");
		$dumpvars;
		#100ns;
		$finish;
	end


endmodule
