module Control_RX
(
	input Clk,
	input Reset,
	input Start,
	// Output Ports 
	output Shift_Show,
	output Flag_Rx
);

wire control_finish_counter;
wire control_start_counter;

MooreMachine_RX
MachineRx
(
	// Input Ports
	.Clk(Clk),
	.Reset(Reset),
	.Start(Start),//Transfer  
	.Flag(control_finish_counter),
	// Output Ports 
	.Shift_Show(Shift_Show),
	.Flag_out(control_start_counter),
	.Flag_Rx(Flag_Rx)
	
);

Counter2
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