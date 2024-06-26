module addr_decode  (
    input [31:0] alu_rsl_M,
    // input [31:0] mask_address,
    output reg [31:0] addr_dmem,
    output reg [31:0] addr_bus,
    output reg m_sel
); 
    always @(*) begin
        if (alu_rsl_M < 32'd512) begin
            m_sel = 0;
            addr_dmem = alu_rsl_M;
            addr_bus = 32'bz;
        end
        else begin
            m_sel = 1;
            addr_bus = alu_rsl_M;
            addr_dmem = 32'bz;
        end
    end
endmodule