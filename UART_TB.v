module UART_TB;
parameter WORD_LENGTH = 8;

	//Input
	reg  Reset;//
	reg  Clk=0;//
	reg  Serial_In;//
	reg  [WORD_LENGTH - 1 : 0]Parallel_In;
	reg  Transmit;
	//Output
	wire Parity_Error;
	wire [WORD_LENGTH - 1 : 0]Parallel_Out;
	wire Serial_Out;
	wire Flag_Rx;


UART
#(
	.WORD_LENGTH(WORD_LENGTH)
)
UART1
(
//Input
	.Reset(Reset),
	.Clk(Clk),
	.Serial_In(Serial_In),
	.Parallel_In(Parallel_In),
	.Transmit(Transmit),
//Output
	.Parity_Error(Parity_Error),
	.Parallel_Out(Parallel_Out),
	.Serial_Out(Serial_Out),
	.Flag_Rx(Flag_Rx)
	
);

initial 
	forever
		begin
			#2 Clk = !Clk;
		end
initial
	begin
		#0 Reset = 0;
		#2 Reset = 1;
	end

initial
	begin
		#0   Serial_In = 1'b1;
		#12  Serial_In = 1'b0;
		#4   Serial_In = 1'b0;
		#4   Serial_In = 1'b1;
		#4   Serial_In = 1'b1;
		#4   Serial_In = 1'b1;

		#4   Serial_In = 1'b1;
		#4   Serial_In = 1'b1;
		#4   Serial_In = 1'b1;
		#4   Serial_In = 1'b0;

		#4   Serial_In = 1'b1;
	end


initial
	begin
		#0  Parallel_In = 8'b0000_1001;
	end
initial
	begin

		#40 Transmit =  1;
		#4  Transmit =  0; 
	end
endmodule 