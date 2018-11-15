module Shift_Register_Serial_In_Parallel_Out
#(
	parameter WORD_LENGTH = 8
)
(
	//Inputs//
	input Clk,
	input Reset,
	input Serial_In,
	input Shift_Show,
	//Outputs//
	output [WORD_LENGTH - 1 : 0]Parallel_Out
);

reg [WORD_LENGTH - 1 : 0] shiftRegister_logic;
reg [WORD_LENGTH - 1 : 0] parallel_out_signal;

always @(posedge Clk or negedge Reset) 
begin
	if(Reset == 1'b0) 
		   shiftRegister_logic= 0;
	else if (Shift_Show == 1'b1) 
				shiftRegister_logic <= {Serial_In, shiftRegister_logic[WORD_LENGTH -1 : 1]};

end


assign Parallel_Out = shiftRegister_logic;
endmodule 