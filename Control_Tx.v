module Control_Tx
(
	input Clk,
	input Reset,
	input Start,//Transfer
	input Si,
	// Output Ports
	output Enable, 
	output Shift_Load,
	output So
);

wire control_finish_counter;
wire control_start_counter;

MooreMachine_TX
StateMachine
(
	// Input Ports
	.Clk(Clk),
	.Reset(Reset),
	.Start(Start),//Transfer  
	.Flag(control_finish_counter), 
	.Si(Si),
	// Output Ports
	.Enable(Enable), 
	.Shift_Load(Shift_Load),
	.So(So),
	.Flag_out(control_start_counter)
);

Counter
Count
(
	// Input Ports
	.Clk(Clk),
	.Reset(Reset),
	.Enable(control_start_counter),
	// Output Ports
	.Flag(control_finish_counter)
);

endmodule 