module carry_propagate_adder(X,Y,final_sum);
	input [23:0]X;
	input [24:0]Y;  
	output [24:0]final_sum;
	wire [24:0]final_carry;
	reg [23:0]final_sum_temp;

	assign final_carry[0] = 0;

	genvar i;
	generate
		for(i=0; i<24; i++)begin
			full_adder U0(.a(X[i]), .b(Y[i]), .c(final_carry[i]), .sum(final_sum_temp[i]), .carry(final_carry[i+1]));
		end

	//adding the carry generated on the MSB to final sum
	assign final_sum = (final_carry & 25'h1000000)+ final_sum_temp; 

	endgenerate

endmodule
