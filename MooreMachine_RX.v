module MooreMachine_RX
(
	// Input Ports
	input Clk,
	input Reset,
	input Start,//Transfer  
	input Flag,
	// Output Ports
	output Shift_Show,
	output Flag_out,
	output Flag_Rx 
	
);

localparam IDLE = 0;
localparam GOING = 1;

reg 		 current_state;
reg 		 state_shift_show;
reg		 state_flag_out;
reg 		 state_rx_flag;

/**************************************************************************************/

always@(posedge Clk, negedge Reset) begin

	if(Reset == 1'b0)
			current_state <= IDLE;
	else 
	   case(current_state)
		
			IDLE:
				if(Start == 1'b0)
					current_state <= GOING;
				else
					current_state <= IDLE;	
			GOING:
				if(Flag == 1'b1)
					current_state <= IDLE;
				else
					current_state  <= GOING;
			default:
					current_state<= IDLE;
			endcase
end
/*------------------------------------------------------------------------------------------*/

always@(current_state) begin
	 case(current_state)
	 
		IDLE: 
			begin
			state_shift_show = 1'b0;
			state_flag_out   = 1'b0;
			state_rx_flag 	  = 1'b1;
			end
			
		GOING:
			begin
			state_shift_show = 1'b1;
			state_flag_out   = 1'b1;
			state_rx_flag 	  = 1'b0;
			end
			
	default: 		
			begin
			state_shift_show = 1'b0;
			state_flag_out   = 1'b0;
			state_rx_flag 	  = 1'b0;
			end

	endcase
end

// Asignacion de salidas
assign Flag_Rx 	= state_rx_flag;
assign Shift_Show = state_shift_show;
assign Flag_out   = state_flag_out;

endmodule 