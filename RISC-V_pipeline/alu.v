module alu (
        input   [31:0]  A
    ,   input   [31:0]  B
    ,   input   [9:0]   alu_ctrl
    ,   input   [2:0]   Bropcode
    ,   output reg [31:0]  alu_result
    ,   output reg branch

);
    wire [31:0] w0 = (alu_ctrl[0]) ? A + B : 0 ;        // ADD
    wire [31:0] w1 = (alu_ctrl[1]) ? A - B : 0 ;        // SUB
    wire [31:0] w2 = (alu_ctrl[2]) ? A << B[4:0] : 0 ;  // SLL
    wire [31:0] w3 = (alu_ctrl[3]) ? ($sign(A) < $sign(B)) : 0 ;        // SLT
    wire [31:0] w4 = (alu_ctrl[4]) ? ((A) < (B)) : 0 ;// SLTU
    wire [31:0] w5 = (alu_ctrl[5]) ? A ^ B : 0 ;        // XOR
    wire [31:0] w6 = (alu_ctrl[6]) ? A >> B[4:0] : 0 ;       // SRL
    wire [31:0] w7 = (alu_ctrl[7]) ? $sign(A) >>> B[4:0] : 0 ;// SRA
    wire [31:0] w8 = (alu_ctrl[8]) ? A | B : 0 ;        // OR
    wire [31:0] w9 = (alu_ctrl[9]) ? A & B : 0 ;             // AND -
    assign alu_result = w0 ^ w1 ^ w2 ^ w3 ^ w4 ^ w5 ^ w6 ^ w7 ^ w8 ^ w9;
    
    
    localparam beq = 3'b000 ;
    localparam bne = 3'b001 ;
    localparam blt = 3'b100 ;
    localparam bge = 3'b101 ;
    localparam bltu = 3'b110 ;
    localparam bgeu = 3'b111 ;

    always @(*) begin
        case (Bropcode)
            beq:    branch = (A==B) ;
            bne:    branch = (A!=B);
            blt:    branch = A < B ? 1 : 0;
            bge:    branch = A > B ? 1 : 0;
            bltu:   branch = ($unsigned (A) < $unsigned (B) );
            bgeu:   branch = ($unsigned(A) > $unsigned(B));
            default: branch = 0;
        endcase
    end

endmodule 