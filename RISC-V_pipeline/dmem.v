module dmem #(
    parameter address = 32
) (
    input clk,
    input [31:0] wa,
    input [31:0] ra,
    input [31:0] wd,
    input we,
    output [31:0] rd
);
    reg [31:0] dmem [0:255];
    always @(posedge clk) begin
        if (we) begin
            dmem[wa] <= wd ; 
        end
    end
    assign rd = dmem[ra];
endmodule