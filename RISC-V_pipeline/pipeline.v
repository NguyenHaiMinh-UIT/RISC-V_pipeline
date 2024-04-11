module pipeline (
    input clk
);
    controller controller_instance(
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .jump_D(jump_D),
        .branch_D(branch_D),
        .imm_sel(imm_sel),
        .bropcode(bropcode),
        .store_sel_D(store_sel_D),
        .load_sel_D(load_sel_D),
        .alu_ctrl(alu_ctrl),
        .alu_scrA_D(alu_scrA_D),
        .alu_srcB_D(alu_srcB_D),
        .regWrite_D(regWrite_D),
        .memWrite_D(memWrite_D),
        .write_back_D(write_back_D)
    );


    datapath datapath_instance(
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .enable_inst_in(enable_inst_in),
        .alu_srcA_D(alu_srcA_D),
        .alu_srcB_D(alu_srcB_D),
        .regWrite_D(regWrite_D),
        .memWrite_D(memWrite_D),
        .write_back_D(write_back_D),
        .jump_D(jump_D),
        .branch_D(branch_D),
        .STORE_SEL_D(STORE_SEL_D),
        .LOAD_SEL_D(LOAD_SEL_D),
        .BROPCODE_D(BROPCODE_D),
        .immD(immD),
        .INSTRUCTION(INSTRUCTION),
        .ADDRESS(ADDRESS),
        .alu_ctrl_D(alu_ctrl_D),
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7)
    );
endmodule