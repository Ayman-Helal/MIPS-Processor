module control_unit(
    input  [5:0]  opcode,
    input  [5:0]  funct,
    output  reg jump,
    output  reg mem_to_reg,
    output  reg mem_wrt,
    output  reg branch,
    output  reg ALUsrc,
    output  reg reg_des,
    output  reg reg_wrt,
    //output  reg  [1:0]  ALUout,
    output  reg  [2:0]  ALU_control   
);

reg  [1:0]  ALUout;

// Main Decoder 
 always @(*) begin
     case(opcode)
      6'b10_0011: begin
          jump = 1'b0;
          ALUout = 2'b00;
          mem_wrt = 1'b0;
          reg_wrt = 1'b1;
          reg_des = 1'b0;
          ALUsrc = 1'b1;
          mem_to_reg = 1'b1;
          branch = 1'b0;
      end 
      6'b10_1011: begin
          jump = 1'b0;
          ALUout = 2'b00;
          mem_wrt = 1'b1;
          reg_wrt = 1'b0;
          reg_des = 1'b0;
          ALUsrc = 1'b1;
          mem_to_reg = 1'b1;
          branch = 1'b0;
      end
      6'b00_0000: begin
          jump = 1'b0;
          ALUout = 2'b10;
          mem_wrt = 1'b0;
          reg_wrt = 1'b1;
          reg_des = 1'b1;
          ALUsrc = 1'b0;
          mem_to_reg = 1'b0;
          branch = 1'b0; 
      end
      6'b00_1000: begin
          jump = 1'b0;
          ALUout = 2'b00;
          mem_wrt = 1'b0;
          reg_wrt = 1'b1;
          reg_des = 1'b0;
          ALUsrc = 1'b1;
          mem_to_reg = 1'b0;
          branch = 1'b0;
      end
      6'b00_0100: begin
          jump = 1'b0;
          ALUout = 2'b01;
          mem_wrt = 1'b0;
          reg_wrt = 1'b0;
          reg_des = 1'b0;
          ALUsrc = 1'b0;
          mem_to_reg = 1'b0;
          branch = 1'b1;
      end
      6'b00_0010: begin
          jump = 1'b1;
          ALUout = 2'b00;
          mem_wrt = 1'b0;
          reg_wrt = 1'b0;
          reg_des = 1'b0;
          ALUsrc = 1'b0;
          mem_to_reg = 1'b0;
          branch = 1'b0;
      end
      default: begin
         jump = 1'b0;
          ALUout = 2'b00;
          mem_wrt = 1'b0;
          reg_wrt = 1'b0;
          reg_des = 1'b0;
          ALUsrc = 1'b0;
          mem_to_reg = 1'b0;
          branch = 1'b0; 
      end 
     endcase
 end

// ALU Decoder 

always @(*) begin
    case(ALUout)
    2'b00: ALU_control = 3'b010;
    2'b01: ALU_control = 3'b100;
    2'b10: begin
        case (funct)
        6'b10_0000: ALU_control = 3'b010;
        6'b10_0010: ALU_control = 3'b100;
        6'b10_1010: ALU_control = 3'b110;
        6'b01_1100: ALU_control = 3'b101;
        default:    ALU_control = 3'b010;
        endcase
    end 
    default: ALU_control = 3'b010;  
    endcase
    
end
endmodule 