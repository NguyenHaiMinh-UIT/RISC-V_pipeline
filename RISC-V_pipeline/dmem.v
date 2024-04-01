module dmem #(
    parameter address = 32
) (
    input addr,
    output mem
);
    assign mem = addr;
endmodule