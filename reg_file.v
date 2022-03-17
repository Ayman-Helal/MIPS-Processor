module reg_file(
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD3,
    input     clk,
    input     rst,
    input     WE3,
    output wire [31:0] RD1,
    output wire [31:0] RD2   
);

reg [31:0] REG  [32:0];
integer i;

always @(posedge clk , negedge rst) begin
    if (!rst) 
    begin 
        for(i=0; i<32; i=i+1)
        begin
            REG [i] = { (32) {1'b0} };
        end
    end
    else if (WE3)
    begin
        REG[A3] <= WD3;
    end 
end

assign RD1 = REG[A1];
assign RD2 = REG[A2];
endmodule