module registerfile #(
    parameter depth = 32 ,
    parameter width = 32 
)(
        input   clk,rst_n
    ,   input   [4:0]   rs1 //register source 1
    ,   input   [4:0]   rs2 //register source 2
    ,   input   [4:0]   rd  //register destination
    ,   input   [4:0]   ra
    ,   input   [31:0]  Din  // Data in to wite
    ,   input   WE
    ,   output  [31:0]  RD1
    ,   output  [31:0]  RD2
    ,   output  [31:0]  RegData
);
    reg [width-1:0] mem [0:(depth-1)] ;
    integer i;
    //read
    assign RD1 = (rs1 && rs1 == rd && WE == 1) ? Din : mem[rs1]; 
    assign RD2 = (rs2 && rs2 == rd && WE == 1) ? Din : mem[rs2];
    assign RegData = mem[ra];
    always @(posedge clk) begin
     // reset 
        if (~rst_n) begin
            for (i = 0 ; i < depth; i=i+1)begin
                if(i==2) begin
                    mem[i] <= 32'd452; 
                end else begin
                    mem[i] <= 32'b0;
                end
            end
        end
    //write
        else begin
            if (WE && rd!=0)
                mem[rd] <= Din;
        end
    end   
endmodule
