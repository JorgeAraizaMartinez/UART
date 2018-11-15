module MooreMachine_TX
(
	// Input Ports
	input Clk,
	input Reset,
	input Start,//Transfer  
	input Flag, 
	input Si,
	// Output Ports
	output Enable, 
	output Shift_Load,
	output So,
	output Flag_out
	
);

localparam IDLE = 0;
localparam FIRST_CLOCK = 1;
localparam GOING = 2;

reg [1:0] current_state; 
reg 		 state_idle;
reg 		 state_enable;
reg 		 state_shift_load;
reg 		 state_so;
reg		 state_flag_out;

/**************************************************************************************/

always@(posedge Clk, negedge Reset) begin

	if(Reset == 1'b0)
			current_state <= IDLE;
	else 
	   case(current_state)
		
			IDLE:
				if(Start == 1'b1)
					current_state <= FIRST_CLOCK;
				else
					current_state <= IDLE;					
			FIRST_CLOCK:
					current_state <= GOING;
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

always@(current_state, Si) begin
	 case(current_state)
	 
		IDLE: 
			begin
			state_enable     = 1'b0;
			state_shift_load = 1'b1;
			state_so	= 1'b1;
			state_flag_out   = 1'b0;
			end
			
		FIRST_CLOCK: 
			begin
			state_enable     = 1'b1;
			state_shift_load = 1'b1;
			state_so	= 1'b0;
			state_flag_out   = 1'b1;
			end
			
		GOING:
			begin
			state_enable     = 1'b1;
			state_shift_load = 1'b0;
			state_so	= Si;
			state_flag_out   = 1'b1;
			end
			
	default: 		
			begin
			state_enable     = 1'b0;
			state_shift_load = 1'b1;
			state_so			  = 1'b0;
			state_flag_out   = 1'b0;
			end

	endcase
end

// Asignacion de salidas

assign Enable     = state_enable;
assign Shift_Load = state_shift_load;
assign So 	      = state_so;
assign Flag_out   = state_flag_out;

endmodule 