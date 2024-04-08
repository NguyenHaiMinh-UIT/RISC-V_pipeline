module BTB #(parameter SIZE = 1024)(
    input clk, rst_n, 
    input jump_E,
    input branch_E,
    input [19:0] pc_F,
    input [19:0] pc_E,
    input [31:0] pc_target,
    output [31:0] pc_out,
    output hit
);
    reg [51:0] buffer [0:SIZE - 1] ;
    reg valid[0:1023];
    integer  i;
    always @(posedge clk) begin
        if (!rst_n) begin
            for (i=0; i< SIZE -1;i=i+1) begin
                valid[i] <= 0;
            end
        end
        else if (branch_E || jump_E) begin
            buffer[pc_E[9:0]] <= {pc_E, pc_target};
            valid[pc_E[9:0]] <= 1'b1;
        end
    end
    assign hit = (valid[pc_F[9:0]] == 1 &&  buffer[pc_F[9:0]][51:32] == pc_F);
    assign pc_out = hit ? buffer[pc_F[9:0]][31:0] : 32'b0;
endmodule
