module WB_register (
    input clk,rst_n,
    input write_enable_RF_M,
    input [1:0]  write_back_M,
    input [31:0] alu_rsl_M,
    input [31:0] write_back_data_M,  
    input [31:0] imm_extended_M,
    input [4:0] rd_M,
    input [31:0] pc4_M,

    output write_enable_RF_W,
    output [1:0] write_back_W,
    output [31:0] alu_rsl_W,
    output [31:0] write_back_data_W,
    output [31:0] imm_extended_W,
    output [4:0] rd_W,
    output [31:0] pc4_W
);
    always @(posedge clk) begin
        if (!rst_n) begin
            write_enable_RF_W <= 0;
            alu_rsl_W <= 0;
            write_back_data_W <= 0;
            imm_extended_W <= 0;
            rd_W <= 0;
            pc4_W <= 0;
        end
        else 
            write_enable_RF_W <= write_enable_RF_M;
            alu_rsl_W <= alu_rsl_M;
            write_back_data_W <= write_back_data_M;
            imm_extended_W <= imm_extended_M;
            rd_W <= rd_M;
            pc4_W <= pc4_M;
    end
endmodule