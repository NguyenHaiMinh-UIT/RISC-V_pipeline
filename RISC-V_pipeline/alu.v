module alu (
        input   [31:0]  A
    ,   input   [31:0]  B
    ,   input   [9:0]   alu_ctrl
    ,   output  [31:0]  alu_result

);
    wire [31:0] w0 = (alu_ctrl[0]) ? A + B : 0 ;        // ADD
    wire [31:0] w1 = (alu_ctrl[1]) ? A - B : 0 ;        // SUB
    wire [31:0] w2 = (alu_ctrl[2]) ? A << B[4:0] : 0 ;  // SLL
    wire [31:0] w3 = (alu_ctrl[3]) ? ($sign(A) < $sign(B)) : 0 ;        // SLT
    wire [31:0] w4 = (alu_ctrl[4]) ? ((A) < (B)) : 0 ;// SLTU
    wire [31:0] w5 = (alu_ctrl[5]) ? A ^ B : 0 ;        // XOR
    wire [31:0] w6 = (alu_ctrl[6]) ? A >> B[4:0] : 0 ;       // SRL
    wire [31:0] w7 = (alu_ctrl[7]) ? {A[31], (A>>B[4:0])} : 0 ;// SRA
    wire [31:0] w8 = (alu_ctrl[8]) ? A | B : 0 ;        // OR
    wire [31:0] w9 = (alu_ctrl[9]) ? A & B : 0 ;             // AND -
    assign alu_result = w0 ^ w1 ^ w2 ^ w3 ^ w4 ^ w5 ^ w6 ^ w7 ^ w8 ^ w9;
endmodule 