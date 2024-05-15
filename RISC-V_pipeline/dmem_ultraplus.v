module dmem_ultraplus (
    input clk,
    input write_enable_dmem,
    input [2:0] store_sel_M,
    input [2:0]  load_sel_M,
    input wire [31:0] mem_WA,  mem_WD, mem_RA,
    output [31:0] mem_RD,
    output [31:0] MemData
);
wire [1:0] offset;
reg [31:0] dmem [0:1023]  ;
// reg [7:0] mem8_0, mem8_1, mem8_2, mem8_3;
// reg [15:0] mem16_0, mem16_2;
wire [9:0] addr;
assign addr = mem_WA[11:2];
assign offset = mem_WA[1:0];
//------------------------------------------------------------------------//
// reg [7:0] mem8_0 [0:1023] ;
// reg [7:0] mem8_1 [0:1023] ;
// reg [7:0] mem8_2 [0:1023] ;
// reg [7:0] mem8_3 [0:1023] ;
integer i;
initial begin
    for (i=0;i<1024;i=i+1) begin
        // mem8_0[i] <= 32'b0;
        // mem8_1[i] <= 32'b0;
        // mem8_2[i] <= 32'b0;
        // mem8_3[i] <= 32'b0;
        dmem[i] <= 32'b0;
    end
end
// always @(posedge clk) begin
//     if (write_enable_dmem) begin
//         case (store_sel_M)
//                 3'b000 : begin 
//                     if (offset == 2'b00) begin
//                         mem8_0[addr] <= mem_WD[7:0];
//                     end
//                     else if (offset == 2'b01) begin
//                         mem8_1[addr]  <= mem_WD[7:0];
//                     end 
//                     else if (offset == 2'b10) begin
//                         mem8_2[addr]  <= mem_WD[7:0];
//                     end
//                     else begin
//                         mem8_3[addr]  <= mem_WD[7:0];
//                     end
//                 end
//                 3'b001: begin
//                     if (offset == 2'b00) begin
//                         mem8_0[addr] <= mem_WD[7:0];
//                         mem8_1[addr] <= mem_WD[15:8];
//                     end 
//                     else  begin
//                         mem8_2[addr] <= mem_WD[23:16];
//                         mem8_3[addr] <= mem_WD[31:24];
//                     end
//                 end
//                 3'b010: begin
//                     mem8_0[addr] <= mem_WD[7:0];
//                     mem8_1[addr] <= mem_WD[15:8];
//                     mem8_2[addr] <= mem_WD[23:16];
//                     mem8_3[addr] <= mem_WD[31:24];
//                 end
//                 default: begin
//                     mem8_0[addr] <= 32'b0;
//                     mem8_1[addr] <= 32'b0;
//                     mem8_2[addr] <= 32'b0;
//                     mem8_3[addr] <= 32'b0;
//                 end
//             endcase
//         // dmem[addr] <= {mem8_3[addr],mem8_2[addr],mem8_1[addr],mem8_0[addr]};    
//     end
// end
// assign MemData = {mem8_3[mem_RA[9:0]],mem8_2[mem_RA[9:0]],mem8_1[mem_RA[9:0]],mem8_0[mem_RA[9:0]]};
// // assign mem_RD = {mem8_3[addr], mem8_2[addr], mem8_1[addr], mem8_0[addr]};
// wire [31:0] temp;
// assign temp [7:0] = mem8_0[addr];
// assign temp [15:8] = mem8_1[addr];
// assign temp [23:16] = mem8_2[addr];
// assign temp [31:24] = mem8_3[addr];

// assign mem_RD = temp;
// assign mem_RD = dmem[addr];
//  //  // ------------------------------------------------------------------// // //
// always @(posedge clk) begin
//     if (write_enable_dmem) begin
//         case (store_sel_M)
//             3'b000 : begin
//                 if (offset == 2'b00) begin
//                     mem8_0 <= mem_WD[7:0];
//                     dmem[addr] <= {dmem[addr][31:8],mem8_0};
//                 end
//                 else if (offset == 2'b01) begin
//                     mem8_1 <= mem_WD[7:0];
//                     dmem[addr] <= {dmem[addr][31:16],mem8_1,dmem[addr][7:0]};
//                 end
//                 else if (offset == 2'b10) begin
//                     mem8_2 <= mem_WD[7:0];
//                     dmem[addr] <= {dmem[addr][31:24], mem8_2, dmem[addr][15:0]};
//                 end
//                 else begin
//                     mem8_3 <= mem_WD[7:0];
//                     dmem[addr] <= {mem8_3, dmem[addr][23:0]};
//                 end
//             // dmem[addr] <= {mem8_3, mem8_2, mem8_1, mem8_0};
//             end 
//             3'b001 : begin
//                 if (offset == 2'b00) begin
//                     mem8_0 <= mem_WD[7:0];
//                     mem8_1 <= mem_WD[15:8];
//                 dmem[addr] <= {dmem[addr][31:16], mem8_1, mem8_0};
//                 end
//                 else begin
//                     mem8_2 <= mem_WD[7:0];
//                     mem8_3 <= mem_WD[15:8];
//                     dmem[addr] <= {mem8_3,mem8_2,dmem[addr][15:0]};
//                 end
//             // dmem[addr] <= {mem8_3, mem8_2, mem8_1, mem8_0};
//             end
//             3'b010 : begin
//                 //  dmem[addr] <= mem_WD;
//                     mem8_0 <= mem_WD[7:0];
//                     mem8_1 <= mem_WD[15:8];
//                     mem8_2 <= mem_WD[23:16];
//                     mem8_3 <= mem_WD[31:24];
//             dmem[addr] <= {mem8_3, mem8_2, mem8_1, mem8_0};    
//             end
//             default:  dmem[addr] <= 32'bx;
//         endcase
//     end
// end
//     assign MemData = dmem[mem_RA[9:0]];
//     assign mem_RD = dmem[addr];

//  //  // ------------------------------------------------------------------// // //
    always @(posedge clk) begin
        if (write_enable_dmem) begin //write operation
            case (store_sel_M)
                3'b000 : begin 
                    if (offset == 2'b00) begin
                        dmem[addr] [7:0] <= mem_WD[7:0];
                    end
                    else if (offset == 2'b01) begin
                        dmem[addr] [15:8] <= mem_WD[7:0];
                    end
                    else if (offset == 2'b10) begin
                        dmem[addr] [23:16] <= mem_WD[7:0];
                    end
                    else begin
                        dmem[addr] [31:24] <= mem_WD[7:0];
                    end
                end
                3'b001: begin
                    if (offset == 2'b00) begin
                        dmem[addr] [15:0] = mem_WD[15:0];
                    end 
                    else begin
                        dmem[addr] [31:16] = mem_WD[15:0];
                    end
                end
                3'b010: begin
                    dmem[addr] = mem_WD;
                end
                default: dmem[addr] = 32'bx ;
            endcase
        end
    end
    assign MemData = dmem[mem_RA[9:0]];
    assign mem_RD = dmem[addr];
    // assign dout = dmem[addr];
    // always @(*) begin
    //     case (load_sel_M)
    //         3'b000: begin
    //             if (offset == 2'b00)    mem_RD = {{24{dout[7]}}, dout[7:0]};
    //             else if (offset == 2'b01) mem_RD = {{24{dout[15]}}, dout[15:8]};
    //             else if (offset == 2'b10) mem_RD = {{24{dout[23]}}, dout[23:16]};
    //             else                      mem_RD = {{24{dout[31]}}, dout[31:24]};   
    //         end 
    //         3'b001: begin
    //             if (offset == 2'b00) mem_RD = {{16{dout[15]}}, dout[15:0]};
    //             else                 mem_RD = {{16{dout[31]}}, dout[31:15]};
    //         end
    //         3'b010: begin
    //             mem_RD = dout [31:0];
                 
    //         end
    //         3'b100: begin
    //             if (offset == 2'b00)      mem_RD = {24'b0, dout[7:0]};
    //             else if (offset == 2'b01) mem_RD = {24'b0, dout[15:8]};
    //             else if (offset == 2'b10) mem_RD = {24'b0, dout[23:16]};
    //             else                      mem_RD = {24'b0, dout[31:24]};  
    //         end
    //         3'b101: begin
    //             if (offset == 2'b00) mem_RD = {16'b0, dout[15:0]};
    //             else                 mem_RD = {16'b0, dout[31:15]};
    //         end
    //         default: mem_RD = dout;
    //     endcase
    // end
endmodule