module loadhazard (
    input [4:0] rs1D,
    input [4:0] rs2D,
    input [4:0] rdE,
    input [1:0] write_back_E,
    output stallF,
    output stallD,
    output FlushE
);
    wire hazard ;
    assign hazard = ((write_back_E == 2'b01) && ((rs1D == rdE) || (rs2D == rdE))) ? 1 : 0;
    assign stallF = hazard ;
    assign stallD = hazard ;
    assign FlushE = hazard ;
endmodule