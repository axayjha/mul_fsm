module mul_test_bench;
	reg [15:0] data_in;
	reg clk, start;
	wire done;

	datapath DP (eqz, LdA, LdB, LdP, clrP, decB, data_in, clk);
	controller CON (LdA, LdB, LdP, clrP, decB, done, clk, eqz, start);

	initial
		begin
			clk = 1'b0;
			#3 start = 1'b1;
			#500 $finish;
		end

	always #5 clk = ~clk;
	
	initial
		begin
			#17 data_in = 5;
			#10 data_in = 6;
			
		end	
	initial
		begin
			$monitor($time, " %d %b", DP.y, done);
			$dumpfile("mul.vcd"); $dumpvars(0, mul_test_bench);

		end	
endmodule		