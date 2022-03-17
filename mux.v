module mux
#(parameter width)
(
    input  [width-1:0] in1,
    input  [width-1:0] in2,
    input sel,
    output reg [width-1:0] mux_out
);


always @(*) begin
    case(sel)
    1'b0: mux_out = in1;
    1'b1: mux_out = in2;
    endcase
end
endmodule 
