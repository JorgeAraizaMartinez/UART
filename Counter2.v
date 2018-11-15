/*********************** 
* Name:
*	Counter.v
* Description:
* Contador con enable y bandera de salida
* 
* Inputs:
*	clk: Input Clock  
*	reset: reset de entrada el modulo
* 	enable: enable de entrada al modulo
* Outputs:
*  flag: Flag de salida
* Version:  
*	1.0
* Author: 
*	Ivan Martinez Flores & Jorge Araiza Martinez 
* Fecha: 
*	2/10/2018
***********************/
module Counter2
#(
	// Parameter Declarations
	parameter WORD_LENGTH = 8
)

(
	// Input Ports
	input Clk,
	input Reset,
	input Enable,
	
	// Output Ports
	output Flag
);

reg flag_r = 1'b0;
reg [WORD_LENGTH * 2 - 1 : 0] counter_r;

always@(posedge Clk or negedge Reset) 
begin
	if (Reset == 1'b0) 
	begin
		counter_r <= {WORD_LENGTH * 2 - 1 {1'b0}};
		flag_r <= 1'b0;
	end
	else if(Enable == 1'b1)
	begin
		if (counter_r == WORD_LENGTH - 2) 
		begin
			flag_r = 1'b1;
			counter_r = -1;
		end
		else
		begin
			flag_r = 1'b0;
			counter_r = counter_r + 1;
		end	
	end
end
	
assign Flag = flag_r;
		
endmodule 