module dmem #(
    parameter address = 32
) (
    input clk,
    input [31:0] wa,
    input [31:0] ra,
    input [31:0] wd,
    input we,
    output  [31:0] rd,
    output [31:0] check_done,
    output [31:0] MemData

);
    reg [31:0] dmem [0:1023];
    always @(posedge clk) begin
        if (we) begin
            dmem[wa[11:2]] <= wd ; 
        end
    end
    assign rd = dmem[wa[11:2]];
    assign MemData = dmem[ra[9:0]];
    assign check_done = dmem[0];
endmodule