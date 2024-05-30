module BTB (
    input clk, rst_n, 
    input jump_E,
    input branch_E,
    input [23:0] pc_F,
    input [23:0] pc_E,
    input [31:0] pc_target,
    output [31:0] pc_out,
    output hit
);
    reg [55:0] buffer [0:255] ;
    reg valid[0:255];
    integer  i;
    always @(posedge clk) begin
        if (!rst_n) begin
            for (i=0; i< 256 ;i=i+1) begin
                valid[i] <= 0;
            end
        end
        else if (branch_E || jump_E) begin
            buffer[pc_E[7:0]] <= {pc_E, pc_target};
            valid[pc_E[7:0]] <= 1'b1;
        end
    end
    assign hit = (valid[pc_F[7:0]] && (buffer[pc_F[7:0]][55:32] == pc_F)) ? 1'b1 : 1'b0;
    assign pc_out = buffer[pc_F[7:0]][31:0]; // pcout = pc target
endmodule
