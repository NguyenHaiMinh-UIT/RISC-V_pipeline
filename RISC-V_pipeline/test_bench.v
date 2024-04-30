`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2024 04:00:56 PM
// Design Name: 
// Module Name: test_bench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// `include "C:\Users\night\Desktop\HK8\KLTN\risc-v_pipeline\RISC-V_pipeline\pipeline.v"
// `include "RISC-V_pipeline/pipeline.v"
module test_bench();
    reg clk;
    reg rst_n;
    reg start;
    reg [31:0] instr;
    reg [31:0] address;
    reg [31:0] i_mem [ 0:1023] ;
    reg DataOrReg;
    reg [31:0] check_address;
    wire [31:0] TB_check_done;
    wire [31:0] value;
    wire [31:0] ALU_RESULT;
    integer i;
    
    
    pipeline pipeline_instance(
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .DataOrReg(DataOrReg),
        .address(address),
        .instruction(instr),
        .check_address(check_address),
        .ALU_RESULT(ALU_RESULT),
        .value(value),
        .Top_Check_Done(TB_check_done)
    );

    initial begin
        $readmemh("hex_file.mem", i_mem);
    end
    always #6 clk = ~clk;
    initial begin
        clk = 1'b0;
        i = 0;
        rst_n = 1;
        start = 1;
        #12;
        rst_n = 0;
        #12;
        start = 1;
        rst_n = 1;
    repeat (77) @(posedge clk) begin
       address = i;
       instr = i_mem[i];
       i=i+1; 
    end
    start = 0;
    
#3500
    DataOrReg = 0;
    check_address = 32'd15;
    #12;
     $stop;
    end
//    always @(posedge clk)  begin
//        if(TB_check_done == 1)begin
//            DataOrReg = 1;
//            check_address = 32'd24;
//            $stop;
//        end
//    end
endmodule
