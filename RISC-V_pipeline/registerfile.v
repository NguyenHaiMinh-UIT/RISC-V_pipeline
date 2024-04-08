module registerfile #(
    parameter depth = 32 ,
    parameter width = 32 
)(
        input   clk,rst_n
    ,   input   [4:0]   rs1 //register source 1
    ,   input   [4:0]   rs2 //register source 2
    ,   input   [4:0]   rd  //register destination
    ,   input   [31:0]  Din  // Data in to wite
    ,   input   WE
    ,   output  [31:0]  RD1
    ,   output  [31:0]  RD2
);
    reg [width-1:0] mem [0:(depth-1)] ;
    integer i;
    //read
    assign RD1 = mem[rs1];
    assign RD2 = mem[rs2];
    always @(posedge clk or negedge rst_n) begin
    // reset 
        if (~rst_n) begin
            for (i = 0 ; i < depth; i=i+1)begin
                mem[i] <= 32'b0;
            end
        end
    //write
        else begin
            if (WE && (rd!=0) )
                mem[rd] <= Din;
        end
    end

    
endmodule
