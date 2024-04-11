module branchcomp (
    input [2:0] Bropcode,
    input [31:0] A,B,
    output branch
);
    localparam beq = 3'b000 ;
    localparam bne = 3'b001 ;
    localparam blt = 3'b100 ;
    localparam bge = 3'b101 ;
    localparam bltu = 3'b110 ;
    localparam bgeu = 3'b111 ;

    always @(*) begin
        case (Bropcode)
            beq:    branch = (A==B) ;
            bne:    branch = (A!=B);
            blt:    branch = A < B ? 1 : 0;
            bge:    branch = A > B ? 1 : 0;
            bltu:   branch = ($unsigned (A) < $unsigned (B) );
            bgeu:   branch = ($unsigned(A) > $unsigned(B));
            default: branch = 0;
        endcase
    end
    
endmodule
