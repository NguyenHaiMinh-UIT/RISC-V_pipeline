
module controller (
    // input clk, rst_n,
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,

    output reg  [1:0] jump_D,
    output reg  branch_D,
    output reg  [2:0] imm_sel,
    output reg  [2:0] bropcode,
    output reg  [2:0] store_sel_D,
    output reg  [2:0] load_sel_D,
    output reg  [9:0] alu_ctrl,
    output reg  alu_scrA_D,
    output reg  alu_srcB_D,
    output reg  regWrite_D,
    output reg  memWrite_D,
    output reg  [1:0] write_back_D
);
    localparam R_type = 7'd51;
    localparam I_type = 7'd19;
    localparam B_type = 7'd99;
    localparam S_type = 7'd35;
    localparam LUI    = 7'd55;
    localparam AUIPC  = 7'd23; 
    localparam I_load_type = 7'd3;
    localparam JARL   = 7'd103;
    localparam JAL    = 7'd111;

    ///======= USE FOR ALU CONTROL =====///
    localparam   add     =   10'd1;
    localparam   sub     =   10'd2;
    localparam   sll     =   10'd4;
    localparam   slt     =   10'd8;
    localparam   sltu    =   10'd16;
    localparam   xorr    =   10'd32;
    localparam   srl     =   10'd64;
    localparam   sra     =   10'd128;
    localparam   orr     =   10'd256;
    localparam   andd    =   10'd512;
    

    always @(*) begin
        case (opcode)
           R_type : begin
            jump_D = 0;
            branch_D = 0;
            imm_sel = 3'b010;
            // bropcode = 3'bx;
            store_sel_D = 3'b111;
            load_sel_D  = 3'b111;
            alu_scrA_D = 0;
            alu_srcB_D = 0;
            regWrite_D = 1;
            memWrite_D = 0;
            write_back_D = 2'b00;
           end 
           I_type : begin
           case (funct3)
            3'b001 : imm_sel = 3'b101;
            3'b101 : imm_sel = 3'b101; 
            default: imm_sel = 3'b000;
           endcase
            jump_D = 0;
            branch_D = 0;
            // imm_sel = 3'b000;
            // bropcode = 3'bx;
            store_sel_D = 3'b111;
            load_sel_D  = 3'b111;
            alu_scrA_D = 0;
            alu_srcB_D = 1;
            regWrite_D = 1;
            memWrite_D = 0;
            write_back_D = 2'b00;
           end
           B_type : begin
            jump_D = 0;
            branch_D = 1;
            imm_sel = 3'b010;
            store_sel_D = 3'b111;
            load_sel_D = 3'b111;
            alu_scrA_D = 0;
            alu_srcB_D = 0;
            regWrite_D = 0;
            memWrite_D = 0;
            write_back_D = 2'b01;
           end
           S_type : begin
            jump_D = 0 ;
            branch_D = 0;
            imm_sel = 3'b001;
            load_sel_D = 3'b111;
            // case (funct3)
            //    3'b000 : store_sel_D = 2'b10;
            //    3'b001 : store_sel_D = 2'b01;
            //    3'b010 : store_sel_D = 2'b00;
            //     default: store_sel_D = 3'b111;
            // endcase
            store_sel_D = funct3;
            alu_scrA_D = 0;
            alu_srcB_D = 1;
            regWrite_D = 0;
            memWrite_D = 1;
            write_back_D = 2'b01;
           end
           I_load_type : begin
            jump_D = 0;
            branch_D = 0;
            imm_sel = 3'b000;
            store_sel_D = 3'b111;
            // case (funct3)
            //     3'b000 : load_sel_D = 3'b010; // LB
            //     3'b001 : load_sel_D = 3'b001; // LH
            //     3'b100 : load_sel_D = 3'b100; // LBU
            //     3'b101 : load_sel_D = 3'b011; // LHU
            //     3'b010 : load_sel_D = 3'b000; // LW
            //     default: load_sel_D = 3'b111;
            // endcase
            load_sel_D = funct3;
            alu_scrA_D = 0;
            alu_srcB_D = 1;
            regWrite_D = 1;
            memWrite_D = 0;
            write_back_D = 2'b01;
           end
           LUI : begin
            jump_D = 0;
            branch_D = 0;
            imm_sel = 3'b011;
            store_sel_D = 3'b111;
            load_sel_D = 3'b111;
            alu_scrA_D = 1'b0;
            alu_srcB_D = 1'b0;
            regWrite_D = 1;
            memWrite_D = 0;
            write_back_D = 2'b11;
           end
           AUIPC : begin
            jump_D = 0;
            branch_D = 0;
            imm_sel = 3'b011;
            store_sel_D = 3'b111;
            load_sel_D = 3'b111;
            alu_scrA_D = 1;
            alu_srcB_D = 1;
            regWrite_D = 1;
            memWrite_D = 0;
            write_back_D = 2'b00;
           end
           JARL : begin
            jump_D = 2'b10;
            branch_D = 0;
            imm_sel = 3'b000;
            store_sel_D = 3'b111;
            load_sel_D = 3'b111;
            alu_scrA_D = 1'b0;
            alu_srcB_D = 1'b0;
            regWrite_D = 1;
            memWrite_D = 0;
            write_back_D = 2'b10;
           end
           JAL : begin
            jump_D = 2'b01;
            branch_D = 0;
            imm_sel = 3'b100;
            store_sel_D = 3'b111;
            load_sel_D = 3'b111;
            alu_scrA_D = 0;
            alu_srcB_D = 0;
            regWrite_D = 1;
            memWrite_D = 0;
            write_back_D = 2'b10;
           end  
            default: begin
            jump_D = 0;
            branch_D = 0;
            imm_sel = 3'bx;
            // bropcode = 3'bx;
            store_sel_D = 3'b111;
            load_sel_D  = 3'b111;
            alu_scrA_D = 0;
            alu_srcB_D = 0;
            regWrite_D = 0;
            memWrite_D = 0;
            write_back_D = 2'b00;
            end
        endcase
    end
    always @(*) begin // bropcode
        if (opcode == 7'd99) begin
            case (funct3)
                3'b000 : bropcode = 3'b000; 
                3'b001 : bropcode = 3'b001;
                3'b100 : bropcode = 3'b100;
                3'b101 : bropcode = 3'b101;
                3'b110 : bropcode = 3'b110;
                3'b111 : bropcode = 3'b111;
                default: bropcode = 3'b010;
            endcase
        end
        else bropcode = 3'b010;
    end
    always @(*) begin
        casex ({opcode,funct3, funct7}) 
            17'b0110011_000_0000000 : alu_ctrl = add;
            17'b0110011_000_0100000 : alu_ctrl = sub;
            17'b0110011_001_0000000 : alu_ctrl = sll;
            17'b0110011_010_0000000 : alu_ctrl = slt;
            17'b0110011_011_0000000 : alu_ctrl = sltu;
            17'b0110011_100_0000000 : alu_ctrl = xorr;
            17'b0110011_101_0000000 : alu_ctrl = srl;
            17'b0110011_101_0100000 : alu_ctrl = sra;
            17'b0110011_110_0000000 : alu_ctrl = orr;
            17'b0110011_111_0000000 : alu_ctrl = andd;

            17'b0010011_000_xxxxxxx : alu_ctrl = add;
            17'b0010011_001_0000000 : alu_ctrl = sll;
            17'b0010011_010_xxxxxxx : alu_ctrl = slt;
            17'b0010011_011_xxxxxxx : alu_ctrl = sltu;
            17'b0010011_100_xxxxxxx : alu_ctrl = xorr;
            17'b0010011_101_0000000 : alu_ctrl = srl;
            17'b0010011_101_0100000 : alu_ctrl = sra;
            17'b0010011_110_xxxxxxx : alu_ctrl = orr;
            17'b0010011_111_xxxxxxx : alu_ctrl = andd;

            17'b0000011_xxx_xxxxxxx : alu_ctrl = add;
            17'b0100001_xxx_xxxxxxx : alu_ctrl = add;
            17'b0110111_xxx_xxxxxxx : alu_ctrl = add;
        default : alu_ctrl = 10'd1;
        endcase
    end

endmodule