module shift 
(
    input  [31:0] IN,
    output reg [31:0] OUT
);

always @(*) begin
    OUT = IN <<2;
end

endmodule 