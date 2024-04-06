module M_register (
    input clk,rst_n,
    input write_enable_RF_E,
    input write_enable_dmem_E,
    input [1:0] write_back_E,
    input [31:0] alu_rsl_E,
    input [31:0] imm_extended_E,
    input [31:0] wd_E,
    input [4:0]  rd_E,
    input [31:0] pc4_E,

    output reg write_enable_RF_M,
    output reg write_enable_dmem_M,
    output reg [1:0] write_back_M,
    output reg [31:0] alu_rsl_M,
    output reg [31:0] imm_extended_M,
    output reg [31:0] wd_M,
    output reg [4:0] rd_M,
    output reg [31:0] pc4_M
);
    always @(posedge clk) begin
        if (!rst_n) begin
            write_enable_RF_M <= 0;
            write_enable_dmem_M <= 0;
            write_back_M <= 0;
            alu_rsl_M <= 0;
            wd_M <= 0;
            rd_M <= 0;
            pc4_M <= 0; 
        end
        else 
            write_enable_RF_M <= write_enable_RF_E;
            write_enable_dmem_M <= write_enable_dmem_E;
            write_back_M <= write_back_E;
            alu_rsl_M <= alu_rsl_E;
            wd_M <= wd_E;
            rd_M <= rd_E;
            pc4_M <= pc4_E;
    end
endmodule