module Parity_Check
#(
	parameter W = 8
)
(
	input [W - 1 : 0]D,
	output Error
);

wire error_data;

assign Error = ~( D[W-1] ^ D[W-2] ^ D[W-3] ^ D[W-4] ^ D[W-5] ^ D[W-6] ^ D[W-7] ^ D[W-8]);

endmodule 