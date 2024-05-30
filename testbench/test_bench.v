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
// `include "../risc-v_pipeline"
module test_bench();
    reg clk;
    reg rst_n;
    reg start;
    reg [31:0] instruction;
    reg [31:0] address;
    reg [31:0] i_mem [ 0:1023] ;
    reg DataOrReg;
    reg [31:0] check_address;
    wire [31:0] value;
    wire [31:0] m_addr, m_data;
    wire m_sel, m_rnw;
    reg [31:0] s_data;
    integer i;

    pipeline pipeline_instance(
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .DataOrReg(DataOrReg),
        .address(address),
        .instruction(instruction),
        .check_address(check_address),
        .s_data(s_data),
        .value(value),
        .m_data(m_data),
        .m_addr(m_addr),
        .m_sel(m_sel),
        .m_rnw(m_rnw)
    );


    integer flush_count = 0;
    // integer predict_true = 0;
    integer total_branch = 0;
    initial begin
        $readmemh("for.mem", i_mem);
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
    repeat (100) @(posedge clk) begin
       address = i;
       instruction = i_mem[i];
       i=i+1; 
    end
    start = 0;
    DataOrReg = 1;
    check_address = 32'b0;
// #3500
//     DataOrReg = 0;
//     check_address = 32'd15;
//     #12;
//       $stop;
    end
   always @(posedge clk)  begin
        if (pipeline_instance.datapath_instance.branch_prediction_instance.flush == 1) begin
            flush_count = flush_count + 1 ;
        end
        if (pipeline_instance.datapath_instance.EX_register_instance.branch_E == 1) begin
            total_branch = total_branch + 1 ;
        end
       if( value == 1)begin
            check_address = 32'd1;
        #12;
        $display("flush count: %d\n", flush_count);
        $display("total branch: %d\n", total_branch);
        $display(" result: %d",pipeline_instance.value); 
           $stop;
       end
   end
    
endmodule
