module instruction_Mem (
        input   [31:0] address
    ,   input   [31:0] address1
    ,   input   clk
    // ,   input   we
    ,   input   [31:0] instr_in
    ,   output  [31:0] instr_out_ID
    ,   input         start
);
    wire [31:0] A;
    reg [31:0] i_mem [0:1023];
    // initial begin
    //  $readmemh ("hex_file.mem", i_mem);
    // end
    always @(posedge clk) begin
        if (start)  i_mem[address1[9:0]] <= instr_in;
    end
    assign A = address >> 2;
    assign instr_out_ID = i_mem[A];
    
endmodule