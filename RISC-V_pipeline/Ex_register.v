module Ex_register (
    input clk,rst_n,
    input FlushE,
    input StallE,
    input write_enable_RF_D,
    input write_enable_dmem_D,
    input write_back_D,
    input [10:0] alu_ctrl_D, // alu promax neen phai chinh lai
    input [31:0] alu_srcA_D,
    input [31:0] alu_srcB_D,
    input jump_D,
    input branch_D,
    input takenD,
    input [31:0] pc_D,
    input [31:0] pc4_D,
    input [31:0] imm_extended_D,
    input [4:0]  RD1_D,
    input [4:0]  RD2_D,
    input [4:0]  rs1_D,
    input [4:0]  rs2_D,
    input [4:0]  rd_D,

    output reg  write_enable_RF_E,
    output reg  write_enable_dmem_E,
    output reg  write_back_E, 
    output reg  [10:0] alu_ctrl_E,
    output reg  [31:0] alu_srcA_E,
    output reg  [31:0] alu_srcB_E,
    output reg  jump_E,
    output reg  branch_E,
    output reg  takenE,
    output reg  [31:0] pc_E,
    output reg  [31:0] pc4_E,
    output reg  [31:0] imm_extended_E,
    output reg  [4:0] RD1_E,
    output reg  [4:0] RD2_E,
    output reg  [4:0] rs1_E,
    output reg  [4:0] rs2_E,
    output reg  [4:0] rd_E

);
    always @(posedge clk) begin
        if (!rst_n) begin 
            write_enable_RF_E <= 0;
            write_enable_dmem_E <= 0;
            write_back_E <= 0;
            alu_ctrl_E <= 0;
            alu_srcA_E <= 0;
            alu_srcB_E <= 0;
            jump_E <= 0;
            branch_E <= 0;
            takenE <= 0;
            pc_E <= 0;
            pc4_E <= 0;
            imm_extended_E <= 0;
            RD1_E <= 0;
            RD2_E <= 0;
            rs1_E <= 0;
            rs2_E <= 0;
            rd_E <= 0;         
        end
        else if (FlushE) begin
            write_enable_RF_E <= 0;
            write_enable_dmem_E <= 0;
            write_back_E <= 0;
            alu_ctrl_E <= 10'b0;
            alu_srcA_E <= 32'b0;
            alu_srcB_E <= 32'b0;
            jump_E <= 0;
            branch_E <= 0;
            takenE <= 0;
            pc_E <= 32'b0;
            pc4_E <= 32'b0;
            imm_extended_E <= 32'b0;
            RD1_E <= 5'b0;
            RD2_E <= 5'b0;
            rs1_E <= 5'b0;
            rs2_E <= 5'b0;
            rd_E  <= 5'b0;         
        end
        else if (StallE) begin
            write_enable_RF_E <= write_enable_RF_E;
            write_enable_dmem_E <= write_enable_dmem_E;
            write_back_E <= write_back_E;
            alu_ctrl_E <= alu_ctrl_E;
            alu_srcA_E <= alu_srcA_E;
            alu_srcB_E <= alu_srcB_E;
            jump_E <= jump_E;
            branch_E <= branch_E;
            takenE <= takenE;
            pc_E <= pc_E;
            pc4_E <= pc4_E;
            imm_extended_E <= imm_extended_E;
            RD1_E <= RD1_E;
            RD2_E <= RD2_E;
            rs1_E <= rs1_E;
            rs2_E <= rs2_E;
            rd_E  <= rd_E;   
        end
        else begin
            write_enable_RF_E <= write_enable_RF_D;
            write_enable_dmem_E <= write_enable_dmem_D;
            write_back_E <= write_back_D;
            alu_ctrl_E <= alu_ctrl_D;
            alu_srcA_E <= alu_srcA_D;
            alu_srcB_E <= alu_srcB_D;
            jump_E <= jump_D;
            branch_E <= branch_D;
            takenE <= takenD;
            pc_E <= pc_D;
            pc4_E <= pc4_D;
            imm_extended_E <= imm_extended_D;
            RD1_E <= RD1_D;
            RD2_E <= RD2_D;
            rs1_E <= rs1_D;
            rs2_E <= rs2_D;
            rd_E  <= rd_D;   
        end
    end
endmodule