module Path_Data_TX
#(
	parameter WORD_LENGTH = 8
)
(
	//Inputs//
	input Clk,
	input Reset,
	input [WORD_LENGTH - 1 : 0] Parallel_In,
	input Start,
	//Outputs//
	output Serial_Out
);

wire clk_signal_out;
wire data_serial_out;
wire control_enable;
wire control_shift_load;
wire one_shot_start;

One_Shot
Shot
(
	// Input Ports
	.clk(clk_signal_out),
	.reset(Reset),
	.Start(Start),

	// Output Ports
	.Shot(one_shot_start)
);

Control_Tx
Control
(
	.Clk(clk_signal_out),
	//.Clk(Clk),
	.Reset(Reset),
	.Start(one_shot_start),//Transfer
	.Si(data_serial_out),
	// Output Ports
	.Enable(control_enable), 
	.Shift_Load(control_shift_load),
	.So(Serial_Out)
);

PLL_UART1	
PLL_UART1_inst
(
	//Inputs//
	.inclk0 (Clk),
	//Outputs//
	.c0 (clk_signal_out)
);

Shift_Register_Parallel_In_Serial_Out
Data_TX
(
	// Inputs //
	.Clk(clk_signal_out),
	//.Clk(Clk),
	.Reset(Reset),
	.Enable(control_enable),
	.Shift_Load(control_shift_load),
	.Parallel_In(Parallel_In),
	//Outputs//
	.Serial_Out(data_serial_out)
);

endmodule 