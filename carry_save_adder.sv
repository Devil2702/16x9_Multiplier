//full_adder 
module full_adder(a,b,c,sum,carry);
	input a,b,c;
	output sum,carry;

	assign sum =  a^b^c;
	assign carry = a*b | b*c | c*a;

endmodule:full_adder

module carry_save_adder(p0,p1,p2,p3,p4,p5,p6,p7,p8,sum,carry_out);
	input  [15:0]p0,p1,p2,p3,p4,p5,p6,p7,p8;
	output [23:0]sum;
 	output [24:0]carry_out;
	wire 	 [23:0]s1,s2,s3,s4,s5,s6;
	wire 	 [24:0]c1,c2,c3,c4,c5,c6;
	reg  	 [24:0]pp0,pp1,pp2,pp3,pp4,pp5,pp6,pp7,pp8;

	assign c1[0] = 0;
	assign c2[0] = 0;
	assign c3[0] = 0;
	assign c4[0] = 0;
	assign c5[0] = 0;
	assign c6[0] = 0;
	assign carry_out[0] = 0;

	always@(*)begin
		pp0 = p0;
		pp1 = p1<<1;
		pp2 = p2<<2;
		pp3 = p3<<3;
		pp4 = p4<<4;
		pp5 = p5<<5;
		pp6 = p6<<6;
		pp7 = p7<<7;
		pp8 = p8<<8;
	end
		
	genvar i;
	generate
		for(i=0; i<24; i=i++)begin
			full_adder FA0(pp0[i],pp1[i],pp2[i],s1[i],c1[i+1]);
			full_adder FA1(pp3[i],pp4[i],pp5[i],s2[i],c2[i+1]);
			full_adder FA2(pp6[i],pp7[i],pp8[i],s3[i],c3[i+1]);
		end
	endgenerate	
		
	genvar j;
	generate
		for(j=0; j<24; j++)begin
			full_adder F4(s1[j],c1[j],s2[j],s4[j],c4[j+1]);
			full_adder F5(s3[j],c3[j],c2[j],s5[j],c5[j+1]);
		end
	endgenerate	

	genvar k;
	generate
		for(k=0; k<24; k++)begin
			full_adder F6(s4[k],c4[k],s5[k],s6[k],c6[k+1]);
		end
	endgenerate
		
	genvar l;
	generate
		for(l=0; l<24; l++)begin
			full_adder F7(s6[l],c6[l],c5[l],sum[l],carry_out[l+1]);
		end
	endgenerate
		
endmodule:carry_save_adder
