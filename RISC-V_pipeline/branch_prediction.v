module branch_prediction #(
    parameter SIZE = 1024
) (
    input clk, rst_n,
    input jump_E,
    input branch_E,
    input taken_E,
    input branch, // = T
    input [31:0] pc_F,
    input [31:0] pc_E,
    input [31:0] pc_target,
    input [31:0] pc4,
    output [31:0] pc_next,
    output [31:0] pc_restore,
    output flush,
    output taken_F
);
    wire hit,mux_wire;
    wire [1:0] taken;
    wire [31:0] target_addr;
    BTB #(
        .SIZE(SIZE)
    ) BTB_instance(
        .clk(clk),
        .rst_n(rst_n),
        .jump_E(jump_E),
        .branch_E(branch_E),
        .pc_F(pc_F),
        .pc_E(pc_E),
        .pc_target(pc_target),
        .pc_out(target_addr),
        .hit(hit)
    );
    PHT #(
        .SIZE(SIZE)
    ) PHT_instance(
        .clk(clk),
        .rst_n(rst_n),
        .branch_E(branch_E),
        .jump_E(jump_E),
        .take(),
        .pc_F(pc_F),
        .pc_E(pc_E),
        .predict(taken)
    );
    assign mux_wire = hit & taken[1];
    mux2to1 mux2to1_instance(
        .A(pc4),
        .B(target_addr),
        .sel(mux_wire),
        .S(pc_next)
    );
    assign taken_F = mux_wire;
    // assign {pc_restore,flush} 
endmodule