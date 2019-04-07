module datapath (eqz, LdA, LdB, LdP, clrP, decB, data_in, clk);
	input LdA, LdB, LdP, clrP, decB, clk;
	input [15:0] data_in;
	output eqz;
	wire [15:0] x, y, z, Bout, Bus;

	PIPO_R1 A (x, data_in, LdA, clk);
	PIPO_R2 P (y, z, LdP, clrP, clk);
	counter B (Bout, data_in, LdB, decB, clk);
	add AD (z, x, y);
	comparator COMP (eqz, Bout);
endmodule
