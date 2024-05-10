module dmem_ultra (
    input clk, 
    input write_enable_dmem,
    input [2:0] store,
    input [2:0] load,
    input [31:0] mem_WA, mem_WD,mem_RA,
    output reg [31:0] mem_RD,
    output  [31:0] MemData
);
    localparam SW = 3'b010;          localparam LW = 3'b010;
    localparam SH = 3'b001;          localparam LH = 3'b001;
    localparam SB = 3'b000;          localparam LB = 3'b000;
                                    localparam LHU = 3'b101;
                                    localparam LBU = 3'b100;
    reg [31:0] mem_WD_store;
    wire [31:0] mem_RD_load;
    // STORE
    always @(*) begin
        if (store == SB)    mem_WD_store = {{24{mem_WD[7]}}, mem_WD[7:0]};
        else if (store == SH)   mem_WD_store = {{16{mem_WD[15]}}, mem_WD[15:0]};
        else if (store == SW) mem_WD_store = mem_WD;       
        else mem_WD_store = 32'bx;
    end

    dmem #(
        .address(32)
    ) dmem_instance(
        .clk(clk),
        .wa(mem_WA),
        .wd(mem_WD_store),
        .ra(mem_RA),
        .we(write_enable_dmem),
        .rd(mem_RD_load),
        .MemData(MemData)
    );
    //LOAD
    always @(*) begin
        if (load == LB)             mem_RD = {{24{mem_RD_load[7]}}, mem_RD_load[7:0]} ;
        else if (load == LH)        mem_RD = {{16{mem_RD_load[15]}}, mem_RD_load[15:0]};
        else if (load == LBU)       mem_RD = {24'b0, mem_RD_load[7:0]}; 
        else if (load == LHU)       mem_RD = {16'b0, mem_RD_load[15:0]};
        else if (load == LW)        mem_RD = mem_RD_load;
        else mem_RD = 32'bx;
    end
    
endmodule