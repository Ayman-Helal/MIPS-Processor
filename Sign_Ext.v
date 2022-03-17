module Sign_Ext (
    input      [15:0] sign_in,
    output reg [31:0] sign_out 
);

always @(*) begin
    if (sign_in[15]==1'b0)
      begin 
          sign_out = {16'h0000,sign_in};
      end
    else 
     begin 
        sign_out = {16'hFFFF,sign_in}; 
     end 
end

endmodule 