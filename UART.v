module UART
#(
	parameter WORD_LENGTH = 8
)
(
//Input
	input  Reset,
	input  Clk,
	input  Serial_In,
	input  [WORD_LENGTH - 1 : 0]Parallel_In,
	input  Transmit,
//Output
	output Parity_Error,
	output [WORD_LENGTH - 1 : 0]Parallel_Out,
	output Serial_Out,
	output Flag_Rx
	
);

wire [WORD_LENGTH - 1 : 0] parity_in_signal;
wire parity_out_signal;
wire [WORD_LENGTH - 1 : 0] mux_out_signal;

Path_Data_TX
Tx
(
	//Inputs//
	.Clk(Clk),
	.Reset(Reset),
	.Parallel_In(Parallel_In),
	.Start(Transmit),
	//Outputs//
	.Serial_Out(Serial_Out)
);

Path_Data_RX
Rx
(
	//Inputs//
	.Clk(Clk),
	.Reset(Reset),
	.Serial_In(Serial_In),
	//Outputs//
	.Parallel_Out(parity_in_signal),
	.Flag_Rx(Flag_Rx)
);



Parity_Check
Check
(
	.D(parity_in_signal),
	.Error(parity_out_signal)
);

/*Multiplexer
Mux
(

	.Selector(parity_out_signal),
	.Data_In_A(parity_in_signal),
	.Data_In_B(8'b0000_0000),
	.Data_Out(mux_out_signal)

);

*/
assign Parallel_Out = parity_in_signal;
assign Parity_Error = parity_out_signal;

endmodule 
