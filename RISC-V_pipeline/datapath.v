module datapath (
    input clk, rst_n,
    input start, alu_srcA_D, alu_srcB_D, regWrite_D, memWrite_D, 
    input  branch_D, 
    input [1:0] STORE_SEL_D, write_back_D,jump_D,
    input [2:0] LOAD_SEL_D, BROPCODE_D, immD,
    input [31:0] INSTRUCTION,ADDRESS,
    input [9:0] alu_ctrl_D,
    input [4:0] ra,
    input [31:0] mem_RA,
    output  [6:0] opcode,
    output  [2:0] funct3,
    output  [6:0] funct7,
    output [31:0] ALU_RESULT,
    output [31:0] RegData, MemData,
    output [31:0] Datapath_Check_Done
);
    wire [31:0] PC_RESTORE, PC_NEXT, INSTR_F, INSTR_D, PC_F, PC4_F, PC_D, PC4_D;
    wire [31:0] PC_TARGET, PC_E, PC4_E, PC4_M, PC4_W;
    wire [4:0]   RS1_E, RS2_E, RD_E, RD_M, RD_W ;
    wire [31:0] w1_mux, w2_mux, w3_mux, w4_mux, w5_mux, w6_mux, w7_mux,jalr_target, Din, Dout;
    wire [31:0] ALU_RSL_E, ALU_RSL_M, WB_DATA , IMM_EXTENDED_D, IMM_EXTENDED_E, IMM_EXTENDED_M;
    wire branch, branch_E,  ALU_SRCA_E, ALU_SRCB_E;
    wire regWrite_E, regWrite_M, regWrite_W, memWrite_E, memWrite_M;
    wire [1:0]  write_back_E, write_back_M, write_back_W, jump_E;
    wire flush, stallF, stallD,  flush_E, taken_F, taken_D, taken_E,FLUSH_E, jump ;
    wire [2:0]  LOAD_SEL_E, LOAD_SEL_M, BROPCODE_E;
    wire [9:0] ALU_CTRL_E;
    wire [31:0] RD1_D, RD2_D, RD1_E, RD2_E;
    wire [1:0] STORE_SEL_E, STORE_SEL_M;
    wire [1:0] forwardAE, forwardBE;
    assign FLUSH_E = flush | flush_E;
    assign opcode = INSTR_D[6:0];
    assign funct3 = INSTR_D[14:12];
    assign funct7 = INSTR_D[31:25];
    assign jump = jump_E[1] | jump_E[0] ;
    assign ALU_RESULT = ALU_RSL_E;
    branch_prediction #(
        .SIZE(1024)
    ) branch_prediction_instance(
        .clk(clk),
        .rst_n(rst_n),
        .jump_E(jump),
        .branch_E(branch_E),
        .taken_E(taken_E),
        .branch(branch),
        .pc_F(PC_F),
        .pc_E(PC_E),
        .pc_D(PC_D),
        .pc_target(PC_TARGET),
        .pc4(PC4_F),
        .pc4_E(PC4_E),
        .pc_next(PC_NEXT),
        .pc_restore(PC_RESTORE),
        .flush(flush),
        .taken_F(taken_F)
    ); 
    IF_register PC_instance(
        .clk(clk),
        .rst_n(rst_n),
        .stallF(stallF),
        .flushF(flush),
        .start(start),
        .pc_restore(PC_RESTORE),
        .pc_next(PC_NEXT),
        .pc_out(PC_F)
    );

    instruction_Mem instruction_Mem_instance(
        .address(PC_F),
        .address1(ADDRESS),
        .clk(clk),
        // .we(we),
        .instr_in(INSTRUCTION),
        .instr_out_ID(INSTR_F),
        .start(start)
    );
    add add_PC_4(
        .A(PC_F),
        .B(32'd4),
        .S(PC4_F)
    );

    ID_register ID_register_instance(
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .stallD(stallD),
        .flushD(flush),
        .instr_F(INSTR_F),
        .takenF(taken_F),
        .pc4_F(PC4_F),
        .pc_F(PC_F),
        .instr_D(INSTR_D),
        .pc4_D(PC4_D),
        .pc_D(PC_D),
        .takenD(taken_D)
    );

    registerfile #(
        .depth(32),
        .width(32)
    ) registerfile_instance(
        .clk(clk),
        .rst_n(rst_n),
        .rs1(INSTR_D[19:15]),
        .rs2(INSTR_D[24:20]),
        .rd(RD_W),
        .ra(ra),
        .Din(WB_DATA),
        .WE(regWrite_W),
        .RD1(RD1_D),
        .RD2(RD2_D),
        .RegData(RegData)
    );
    
    signExtend signExtend_instance(
        .instr_D(INSTR_D[31:7]),
        .immD(immD),
        .imm_out_D(IMM_EXTENDED_D)
    );
    
    EX_register EX_register_instance(
        .clk(clk),
        .rst_n(rst_n),
        .FlushE(FLUSH_E),
        .StallE(1'b0),
        .write_enable_RF_D(regWrite_D),
        .write_enable_dmem_D(memWrite_D),
        .write_back_D(write_back_D),
        .alu_ctrl_D(alu_ctrl_D),
        .alu_srcA_D(alu_srcA_D),
        .alu_srcB_D(alu_srcB_D),
        .jump_D(jump_D),
        .branch_D(branch_D),
        .takenD(taken_D),
        .pc_D(PC_D),
        .pc4_D(PC4_D),
        .imm_extended_D(IMM_EXTENDED_D),
        .RD1_D(RD1_D),
        .RD2_D(RD2_D),
        .rs1_D(INSTR_D[19:15]),
        .rs2_D(INSTR_D[24:20]),
        .rd_D(INSTR_D[11:7]),
        .store_sel_D(STORE_SEL_D),
        .load_sel_D(LOAD_SEL_D),
        .Bropcode_D(BROPCODE_D),
        .write_enable_RF_E(regWrite_E),
        .write_enable_dmem_E(memWrite_E),
        .write_back_E(write_back_E),
        .alu_ctrl_E(ALU_CTRL_E),
        .alu_srcA_E(ALU_SRCA_E),
        .alu_srcB_E(ALU_SRCB_E),
        .jump_E(jump_E),
        .branch_E(branch_E),
        .takenE(taken_E),
        .pc_E(PC_E),
        .pc4_E(PC4_E),
        .imm_extended_E(IMM_EXTENDED_E),
        .RD1_E(RD1_E),
        .RD2_E(RD2_E),
        .rs1_E(RS1_E),
        .rs2_E(RS2_E),
        .rd_E(RD_E),
        .store_sel_E(STORE_SEL_E),
        .load_sel_E(LOAD_SEL_E),
        .Bropcode_E(BROPCODE_E)
    );
///-----------------------------------------    

    mux3to1 mux3to1_RD1_instance(
        .in0(RD1_E),
        .in1(WB_DATA),
        .in2(ALU_RSL_M),
        .sel(forwardAE),
        .out(w1_mux)
    );
    mux3to1 mux3to1_RD2_instance(
        .in0(RD2_E),
        .in1(WB_DATA),
        .in2(ALU_RSL_M),
        .sel(forwardBE),
        .out(w2_mux)
    );
    mux2to1 mux2to1_A_instance(
        .A(w1_mux),
        .B(PC_E),
        .sel(ALU_SRCA_E),
        .S(w3_mux)
    );
    mux2to1 mux2to1_B_instance(
        .A(w2_mux),
        .B(IMM_EXTENDED_E),
        .sel(ALU_SRCB_E),
        .S(w4_mux)
    );
    alu alu_instance(
        .A(w3_mux),
        .B(w4_mux),
        .alu_ctrl(ALU_CTRL_E),
        .Bropcode(BROPCODE_E),
        .alu_result(ALU_RSL_E),
        .branch(branch)
    );
    mux2to1 jalr_handle(
        .A(PC_E),
        .B(w1_mux),
        .sel(jump_E[1]),
        .S(jalr_target)
    );
    add PC_ADD (
        .A(jalr_target),
        .B(IMM_EXTENDED_E),
        .S(PC_TARGET)
    );

////----------------------------------------
    harzard_unit harzard_unit_instance(
        .write_enable_RF_M(regWrite_M),
        // .write_back_M(write_back_M),
        .write_enable_RF_W(regWrite_W),
        // .write_back_W(write_back_W),
        .write_back_E(write_back_E),
        .rd_M(RD_M),
        .rd_W(RD_W),
        .rs1_D(INSTR_D[19:15]),
        .rs2_D(INSTR_D[24:20]),
        .rs1_E(RS1_E),
        .rs2_E(RS2_E),
        .rd_E(RD_E),
        .forwardAE(forwardAE),
        .forwardBE(forwardBE),
        .stallF(stallF),
        .stallD(stallD),
        .flushE(flush_E)
    );
    M_register M_register_instance(
        .clk(clk),
        .rst_n(rst_n),
        .write_enable_RF_E(regWrite_E),
        .write_enable_dmem_E(memWrite_E),
        .write_back_E(write_back_E),
        .alu_rsl_E(ALU_RSL_E),
        .imm_extended_E(IMM_EXTENDED_E),
        .wd_E(w2_mux),
        .rd_E(RD_E),
        .pc4_E(PC4_E),
        .store_sel_E(STORE_SEL_E),
        .load_sel_E(LOAD_SEL_E),
        .write_enable_RF_M(regWrite_M),
        .write_enable_dmem_M(memWrite_M),
        .write_back_M(write_back_M),
        .alu_rsl_M(ALU_RSL_M),
        .imm_extended_M(IMM_EXTENDED_M),
        .wd_M(Din),
        .rd_M(RD_M),
        .pc4_M(PC4_M),
        .store_sel_M(STORE_SEL_M),
        .load_sel_M(LOAD_SEL_M)
    );
    dmem_ultra dmem_ultra_instance(
        .clk(clk),
        .write_enable_dmem(memWrite_M),
        .store(STORE_SEL_M),
        .load(LOAD_SEL_M),
        .mem_WA(ALU_RSL_M),
        .mem_WD(Din),
        .mem_RA(mem_RA),
        .mem_RD(Dout),
        .DMEM_Check_Done(Datapath_Check_Done),
        .MemData(MemData)
    );
    WB_register WB_register_instance(
        .clk(clk),
        .rst_n(rst_n),
        .write_enable_RF_M(regWrite_M),
        .write_back_M(write_back_M),
        .alu_rsl_M(ALU_RSL_M),
        .write_back_data_M(Dout),
        .imm_extended_M(IMM_EXTENDED_M),
        .rd_M(RD_M),
        .pc4_M(PC4_M),
        .write_enable_RF_W(regWrite_W),
        .write_back_W(write_back_W),
        .alu_rsl_W(w5_mux),
        .write_back_data_W(w6_mux),
        .imm_extended_W(w7_mux),
        .rd_W(RD_W),
        .pc4_W(PC4_W)
    );
    mux4to1 mux4to1_instance(
        .in0(w5_mux),
        .in1(w6_mux),
        .in2(PC4_W),
        .in3(w7_mux),
        .sel(write_back_W),
        .out(WB_DATA)
    );
endmodule