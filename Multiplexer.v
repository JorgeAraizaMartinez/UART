/********************************************************* 
* Name:
*	Mux.v
* Description:
* 	This module is a Behavioral multiplexer.
* Inputs:
*	Selector: To select between Data_0 or Data_1
*  Data_In_A: Input data
*	Data_In_B: Input data 
* Outputs:
* 	Data_Out: Output data
* VersiÃÂ³n:  
*	1.0
* Author: 
*	Jorge Antonio Araiza Martinez
*  Ivan Martinez Flores
* Fecha: 
*	10/10/2018
*********************************************************************/
module Multiplexer

#(
	parameter WORD_LENGTH = 8
)

(

	input  Selector,
	input  [WORD_LENGTH - 1 : 0] Data_In_A,
	input  [WORD_LENGTH - 1 : 0] Data_In_B,
	output [WORD_LENGTH - 1: 0] Data_Out

);

reg [WORD_LENGTH - 1: 0] bypass;

always@(*) begin
	if (Selector == 1'b1)
		bypass = Data_In_A;
	else 
		bypass = Data_In_B;
end
endmodule 