module DATA(
    input wire clkd,
    input wire rstd,
    input   [31:0] instrd,
    input   [31:0] ReadDatad,
    input   [2:0]  Alucontd,
    input          jumpd,
    input          PCsrcd,
    input          MemtoRegd,
    input          Alusrcd,
    input          RegDstd,
    input          RegWrited, 
    output         zerod,
    output  [31:0] PCd,
    output  [31:0] AluOutd,
    output  [31:0] WriteDatad

);
wire [31:0] mux_out1;
wire [31:0] PCplus4;
wire [31:0] PCbranch;
wire [31:0] PCjump;
wire [31:0] mux_out2;
//wire [31:0] PC_outd;
wire [27:0] shif_out1;
wire [31:0] signlmm;
wire [31:0] shif_out2;
wire [4:0]  WriteReg;
wire [31:0] result;
wire [31:0] Alu1;
wire [31:0] Alu2;
//wire [31:0] RegOut;

assign PCjump = {PCplus4[31:28],shif_out1};

// Mux1
mux #(.width(32)) mux1 (
    .sel(PCsrcd),
    .in1(PCplus4),
    .in2(PCbranch),
    .mux_out(mux_out1)
);

// Mux2
mux #(.width(32)) mux2 (
    .sel(jumpd),
    .in1(mux_out1),
    .in2(PCjump),
    .mux_out(mux_out2)
);

// PC
PC PC_d (
  .PC_in(mux_out2),
  .clk(clkd),
  .rst(rstd),
  .PC_out(PCd)
);

// PC plus 4
PC_plus4 PC_plus4d (
   .PC_plus4_in(PCd),
   .PC_plus4_out(PCplus4) 
);

//shift width modifier
shif_wid shif_wid_d (
    .IN(instrd[25:0]),
    .OUT(shif_out1)
);

//sign extend
Sign_Ext  Sign_Ext_d (
    .sign_in(instrd[15:0]),
    .sign_out(signlmm) 
);

//shifter 
shift shiftd (
    .IN(signlmm),
    .OUT(shif_out2)
);

//Adder 
Adder Adderd (
    .IN_A(shif_out2),
    .IN_B(PCplus4),
    .ADD_out(PCbranch)
);

//Mux3
mux #(.width(5)) mux3 (
    .in1(instrd[20:16]),
    .in2(instrd[15:11]),
    .sel(RegDstd),
    .mux_out(WriteReg)
);

//register file 
reg_file reg_file_d (
    .A1(instrd[25:21]),
    .A2(instrd[20:16]),
    .A3(WriteReg),
    .WD3(result),
    .clk(clkd),
    .rst(rstd),
    .WE3(RegWrited),
    .RD1(Alu1),
    .RD2(WriteDatad)   
);

//mux4
mux #(.width(32)) mux4 (
    .in1(WriteDatad),
    .in2(signlmm),
    .sel(Alusrcd),
    .mux_out(Alu2)
);

// Alu
alu alud (
    .srcA(Alu1),
    .srcB(Alu2),
    .alu_control(Alucontd),
    .zero_flag(zerod),
    .alu_out(AluOutd)
);

//Mux5
mux #(.width(32)) mux5 (
    .in1(AluOutd),
    .in2(ReadDatad),
    .sel(MemtoRegd),
    .mux_out(result)
);

endmodule



