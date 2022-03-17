module MIPS(
    input clk_in,
    input rst_in,
    output [15:0] TestValue
);

wire [31:0] PC_top;
wire [31:0] instr;
wire [31:0] ReadData_top;
wire [31:0] AluOut_top;
wire [31:0] WriteData_top;
wire        MemWrite_top;
wire        RegWrite_top;
wire        RegDst_top;
wire        AluSrc_top;
wire        MemtoReg_top;
wire        Branch_top;
wire        jump_top;
wire    [2:0]    Alucont_top;
wire        PCsrc_top;
wire        zero_top;

assign PCsrc_top = zero_top & Branch_top;


// instruction memory
rom rom_top (
    .addr(PC_top),
    .Dout(instr)
);

// data memory
ram ram_top (
    .WD(WriteData_top),
    .addr(AluOut_top),
    .WE(MemWrite_top),
    .clk(clk_in),
    .rst(rst_in),
    .RD(ReadData_top),
    .test_value(TestValue)
);

// data path
DATA DATA_top (
    .clkd(clk_in),
    .rstd(rst_in),
    .instrd(instr),
    .ReadDatad(ReadData_top),
    .Alucontd(Alucont_top),
    .jumpd(jump_top),
    .PCsrcd(PCsrc_top),
    .MemtoRegd(MemtoReg_top),
    .Alusrcd(AluSrc_top),
    .RegDstd(RegDst_top),
    .RegWrited(RegWrite_top), 
    .zerod(zero_top),
    .PCd(PC_top),
    .AluOutd(AluOut_top),
    .WriteDatad(WriteData_top)
);

//controller
control_unit control_unit_top (
    .opcode(instr[31:26]),
    .funct(instr[5:0]),
    .jump(jump_top),
    .mem_to_reg(MemtoReg_top),
    .mem_wrt(MemWrite_top),
    .branch(Branch_top),
    .ALUsrc(AluSrc_top),
    .reg_des(RegDst_top),
    .reg_wrt(RegWrite_top),
    .ALU_control(Alucont_top)   
);

endmodule 