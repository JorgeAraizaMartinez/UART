module Path_Data_RX
#(
	parameter WORD_LENGTH = 8
)
(
	//Inputs//
	input Clk,
	input Reset,
	input Serial_In,
	//Outputs//
	output [WORD_LENGTH - 1 : 0] Parallel_Out,
	output Flag_Rx
);

wire clk_signal_out;
wire data_serial_out;
wire control_shift_show;
wire one_shot_start;


Control_RX
Cntrl
(
	.Clk(clk_signal_out),
	//.Clk(Clk),
	.Reset(Reset),
	.Start(Serial_In),
	// Output Ports 
	.Shift_Show(control_shift_show),
	.Flag_Rx(Flag_Rx)
);

PLL_UART1	
PLL_UART1_inst
(
	//Inputs//
	.inclk0 (Clk),
	//Outputs//
	.c0 (clk_signal_out)
);

Shift_Register_Serial_In_Parallel_Out
Data_TX
(
	// Inputs //
	.Clk(clk_signal_out),
	//.Clk(Clk),
	.Reset(Reset),
	.Serial_In(Serial_In),
	.Shift_Show(control_shift_show),
	//Outputs//
	.Parallel_Out(Parallel_Out)
);


endmodule 