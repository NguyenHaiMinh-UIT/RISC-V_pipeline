module add4 (
    input [31:0] pc,
    output [31:0] pcplus4
);
    assign pcplus4 = pc + 4;
endmodule