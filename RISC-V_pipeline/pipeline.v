module pipeline (
    input clk, rst_n,
    input start,DataOrReg,
    input [31:0] address,instruction,check_address,
    output [31:0] ALU_RESULT,
    output [31:0] value
);
    wire [6:0] opcode, funct7;
    wire [2:0] funct3;
    wire [9:0] alu_ctrl;
    wire [1:0] jump_D, store_sel, write_back;
    wire branch_D, alu_srcA_D, alu_srcB_D;
    wire [2:0] imm_sel, bropcode , load_sel;
    wire regWrite, memWrite;
    wire [4:0] Reg_RA;
    wire [31:0] Mem_RA, RegData, MemData;
    controller controller_instance(
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .jump_D(jump_D),
        .branch_D(branch_D),
        .imm_sel(imm_sel),
        .bropcode(bropcode),
        .store_sel_D(store_sel),
        .load_sel_D(load_sel),
        .alu_ctrl(alu_ctrl),
        .alu_scrA_D(alu_srcA_D),
        .alu_srcB_D(alu_srcB_D),
        .regWrite_D(regWrite),
        .memWrite_D(memWrite),
        .write_back_D(write_back)
    );


    datapath datapath_instance(
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .alu_srcA_D(alu_srcA_D),
        .alu_srcB_D(alu_srcB_D),
        .regWrite_D(regWrite),
        .memWrite_D(memWrite),
        .write_back_D(write_back),
        .jump_D(jump_D),
        .branch_D(branch_D),
        .STORE_SEL_D(store_sel),
        .LOAD_SEL_D(load_sel),
        .BROPCODE_D(bropcode),
        .immD(imm_sel),
        .INSTRUCTION(instruction),
        .ADDRESS(address),
        .alu_ctrl_D(alu_ctrl),
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .ALU_RESULT(ALU_RESULT),
        .ra(Reg_RA),
        .mem_RA(Mem_RA),
        .RegData(RegData),
        .MemData(MemData)
    );

    demux2to1 demux2to1_instance(
        .in(check_address),
        .sel(DataOrReg),
        .out0(Reg_RA),
        .out1(Mem_RA)
    );
    mux2to1 mux2to1_instance(
        .A(RegData),
        .B(MemData),
        .sel(DataOrReg),
        .S(value)
    );
endmodule