module IF_register (
        input clk,rst_n
    ,   input stallF
    ,   input flushF    
    ,   input   [31:0]  pc_restore
    ,   input   [31:0]  pc_next
    ,   output reg [31:0]  pc_out
);
    always @(posedge clk) begin
        if (!rst_n) begin
            pc_out <= 32'b0;
        end
        else if (flushF) begin
            pc_out <= pc_restore;
        end
        else if (stallF) begin
            pc_out <= pc_out ;
        end
        else pc_out <= pc_next;
    end
endmodule