module signExtend (
        input   [31:7]  instr_D
    ,   input   [2:0]   immD
    ,   output  [31:0]  imm_out_D
);
    localparam I_Imm = 3'b000;
    localparam S_Imm = 3'b001;
    localparam B_Imm = 3'b010;
    localparam U_Imm = 3'b011;
    localparam J_Imm = 3'b100;
    always @(*) begin
        case (immD)
            I_Imm : imm_out_D = {{21{instr_D[31]}}, instr_D[30:20]};
            S_Imm : imm_out_D = {{21{instr_D[31]}}, instr_D[30:25], instr_D[11:7]};
            B_Imm : imm_out_D = {{20{instr_D[31]}}, instr_D[7], instr_D[30:25], instr_D[11:8],1'b0};
            U_Imm : imm_out_D = {{instr_D[31:12]},12'b0};
            J_Imm : imm_out_D = {{12{instr_D[31]}}, instr_D[19:12],instr_D[20], instr_D[30:21],1'b0};
            3'b101: imm_out_D = {27'b0, instr_D[24:20]};
            default: imm_out_D = 32'bx;
        endcase
    end
endmodule