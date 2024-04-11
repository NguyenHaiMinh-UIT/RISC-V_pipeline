module instruction_Mem (
        input   [31:0] address
    ,   input   clk
    // ,   input   we
    ,   input   [31:0] instr_in
    ,   output  [31:0] instr_out_ID
    ,   input         start
);
    wire [31:0] A;
    reg [31:0] i_mem [0:1023];
    $readmemh ("hex_file.mem", i_mem)
    always @(posedge clk) begin
        if (start)  i_mem[A] <= instr_in;
    end
    assign A = address >> 2;
    assign instr_out_ID = i_mem[A];
    
endmodule