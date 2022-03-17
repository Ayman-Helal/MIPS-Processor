module PC_plus4(
    input        [31:0] PC_plus4_in,
    output reg   [31:0] PC_plus4_out 
);
always @(*) begin
    PC_plus4_out = PC_plus4_in +32'd4;  
end
endmodule 