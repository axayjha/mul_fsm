module controller (LdA, LdB, LdP, clrP, decB, done, clk, eqz, start);
	input clk, eqz, start;
	output reg LdA, LdB, LdP, clrP, decB, done;
	reg [2:0] state;
	parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011, s4=3'b100;

	always @(posedge clk)
		begin
			case (state)
				s0: if (start) state <= s1;
				s1: state <= s2;
				s2: state <= s3;
				s3: #2 if (eqz) state <= s4;
				s4: state <= s4;
				default: state <= s0;
			endcase
		end
	always @(state)
		begin
			case (state)
				s0: begin #1 LdA = 0; LdB = 0; LdP = 0; clrP = 0; decB = 0; end 
				s1: begin #1 LdA = 1; end
				s2: begin #1 LdA = 0; LdB = 1; clrP = 1; end
				s3: begin #1 LdB = 0; LdP = 1; clrP = 0; decB = 1; end 
				s4: begin #1 done = 1; LdB = 0; LdP = 0; decB = 0; end
			default: begin #1 LdA = 0; LdB = 0; LdP = 0; clrP = 0; decB = 0; end
			endcase
			
		end	
endmodule