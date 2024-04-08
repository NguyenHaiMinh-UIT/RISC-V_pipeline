module PHT #(parameter SIZE = 1024)(
    input clk, rst_n,
    input branch_E,
    input jump_E,
    input take,
    input [19:0] pc_F,
    input [19:0] pc_E,
    output[1:0] predict
);
    wire [1:0] fsm_state ;
    reg [21:0] buffer [0:SIZE-1];
    reg valid [0:SIZE - 1];
    assign fsm_state = {(buffer[pc_E[9:0]][20]&buffer[pc_E[9:0]][21] | take&(buffer[pc_E[9:0]][20]|buffer[pc_E[9:0]][21])), take};
    integer i;
    always @(posedge clk) begin
        if (!rst_n) begin
            for (i=0; i< SIZE;i=i+1) begin
                valid[i] <= 0;
            end
        end
        else if (branch_E) begin
            buffer[pc_E[9:0]] <= {pc_E, fsm_state} ; 
            valid[pc_E[9:0]] <= 1;
        end
        else if (jump_E) begin
            buffer[pc_E[9:0]] <= {pc_E, 2'b11};
            valid[pc_E[9:0]] <= 1;
        end
        assign predict = (valid[pc_F[9:0]] == 1 &&  buffer[pc_F[9:0]][21:2] == pc_F) ?  buffer[pc_F[9:0]][1:0] : 2'b00;
    end
endmodule