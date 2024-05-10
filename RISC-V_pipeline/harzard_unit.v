module harzard_unit (
    input write_enable_RF_M,
    // input [1:0] write_back_M,
    input write_enable_RF_W,
    // input [1:0] write_back_W,
    input [1:0] write_back_E,
    input [4:0] rd_M,
    input [4:0] rd_W,
    input [4:0] rs1_D,
    input [4:0] rs2_D,
    input [4:0] rs1_E,
    input [4:0] rs2_E,
    input [4:0] rd_E,
    output reg [1:0] forwardAE,
    output reg [1:0] forwardBE,
    output stallF,
    output stallD,
    output flushE
);
    wire hazard;
// forward AE
    always @(*) begin
        if (write_enable_RF_M && (rd_M == rs1_E)) begin
            forwardAE <= 2'b10;
        end
        else if (write_enable_RF_W && (rd_W == rs1_E)) begin         
            forwardAE <= 2'b01;
        end
        else forwardAE <= 2'b00;
    end
// forward BE
    always @(*) begin
        if (write_enable_RF_M && (rd_M == rs2_E)) begin
            forwardBE <= 2'b10;
        end
        else if (write_enable_RF_W && (rd_W == rs2_E)) begin
            forwardBE <= 2'b01;
        end
        else forwardBE <= 2'b00;
    end
// Load hazard
    assign hazard = ((write_back_E == 2'b01) && ((rs1_D == rd_E) || (rs2_D == rd_E))) ? 1 : 0;
    assign stallF = hazard;
    assign stallD = hazard;
    assign flushE = hazard;
endmodule