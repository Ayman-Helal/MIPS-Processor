module Adder (
  input      [31:0]  IN_A,
  input      [31:0]  IN_B,
  output reg [31:0] ADD_out
);

always @(*) begin
    ADD_out = IN_A + IN_B; 
end
endmodule 