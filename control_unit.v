module control_unit (
    input [6:0] op
    ,   input [2:0] funct3
    ,   input funct7

    ,   output ImmD
    ,   output BranchD
    ,   output ALU_ctrl_ID
    ,   output ALU_SrcB_D
    ,   output ALU_SrcA_D
    ,   output Jump_D
    ,   output WriteMem_D
    ,   output WriteBack_D
    ,   output WriteReg_D
);
    
endmodule