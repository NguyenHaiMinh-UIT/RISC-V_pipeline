module ID_register (
    input clk,rst_n,
    input stallD,
    input flushD,
    input [31:0] instr_F,
    input takenF,
    input [31:0] pc4_F,
    input [31:0] pc_F,
    
    output reg [31:0] instr_D,
    output reg [31:0] pc4_D,
    output reg [31:0] pc_D,
    output reg takenD
);
  always @(posedge clk) begin
    if (!rst_n) begin
        instr_D <= 0;
        pc4_D <= 0;
        pc_D <= 0;
        takenD <= 0;
    end
    else if (flushD) begin
        instr_D <= 0;
        pc4_D <= 0;
        pc_D <= 0;
        takenD <= 0;
    end
    else if (stallD) begin
        instr_D <= instr_D;
        pc4_D <= pc4_D;
        pc_D <= pc_D;
        takenD <= takenD;
    end
    else begin
        instr_D <= instr_F;
        pc4_D <= pc4_F;
        pc_D <= pc_F;
        takenD <= takenF;
    end
  end  
endmodule