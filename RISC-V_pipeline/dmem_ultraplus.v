module dmem_ultraplus (
    input clk,
    input write_enable_dmem,
    input [2:0] store_sel_M,
    input [2:0]  load_sel_M,
    input wire [31:0] mem_WA,  mem_WD, mem_RA,
    output   reg [31:0] mem_RD,
    output [31:0] MemData
);
wire [1:0] offset;
reg [31:0] dmem [0:1023]  ;
wire [9:0] addr = mem_WA[11:2];
wire [31:0] dout;
assign offset = mem_WA[1:0];
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
    assign dout = dmem[addr];
    always @(*) begin
        case (load_sel_M)
            3'b000: begin
                if (offset == 2'b00)    mem_RD = {{24{dout[7]}}, dout[7:0]};
                else if (offset == 2'b01) mem_RD = {{24{dout[15]}}, dout[15:8]};
                else if (offset == 2'b10) mem_RD = {{24{dout[23]}}, dout[23:16]};
                else                      mem_RD = {{24{dout[31]}}, dout[31:24]};   
            end 
            3'b001: begin
                if (offset == 2'b00) mem_RD = {{16{dout[15]}}, dout[15:0]};
                else                 mem_RD = {{16{dout[31]}}, dout[31:15]};
            end
            3'b010: begin
                mem_RD = dout [31:0];
                 
            end
            3'b100: begin
                if (offset == 2'b00)      mem_RD = {24'b0, dout[7:0]};
                else if (offset == 2'b01) mem_RD = {24'b0, dout[15:8]};
                else if (offset == 2'b10) mem_RD = {24'b0, dout[23:16]};
                else                      mem_RD = {24'b0, dout[31:24]};  
            end
            3'b101: begin
                if (offset == 2'b00) mem_RD = {16'b0, dout[15:0]};
                else                 mem_RD = {16'b0, dout[31:15]};
            end
            default: mem_RD = dout;
        endcase
    end
endmodule