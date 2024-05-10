module PHT #(parameter SIZE = 256)(
    input clk, rst_n,
    input branch_E,
    input jump_E,
    input take,
    input [7:0] pc_F,
    input [7:0] pc_E,
    output[1:0] predict
);
    wire [1:0] fsm_state ;
    wire [7:0] addr_shared;
    reg [1:0] buffer [0:SIZE-1];
    reg [7:0] GHR;
    assign addr_shared = GHR ^ pc_F ;
    assign fsm_state = {(buffer[pc_E] & buffer[pc_E] | take & (buffer[pc_E] | buffer[pc_E])), take};
    integer i;
    always @(posedge clk) begin
        if (!rst_n) begin
            for (i=0; i< SIZE;i=i+1) begin
                buffer[i] <= 2'b11;
            end
            GHR <= 8'b0;
        end
        else if (branch_E) begin
            GHR <= {GHR[6:0], take};
            buffer[pc_E] <= fsm_state ; 
        end
        else if (jump_E) begin
            GHR <= {GHR[6:0], 1'b1};
            buffer[pc_E] <= 2'b11;
        end
    end
    assign predict = buffer[addr_shared] ;
endmodule