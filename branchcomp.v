module branchcomp (
    input [6:0] Bropcode,
    input [31:0] A,B,
    output branch
);
    parameter beq = 3'b000 ;
    parameter bne = 3'b001 ;
    parameter blt = 3'b100 ;
    parameter bge = 3'b101 ;
    parameter bltu = 3'b110 ;
    parameter bgeu = 3'b111 ;

    always @(*) begin
        case (branch)
            beq:    branch = (A==B) ;
            bne:    branch = (A!=B);
            blt:    branch = A < B ? 1 : 0;
            bge:    branch = A > B ? 1 : 0;
            bltu:   branch = ($signed (A) < $signed (B) );
            bgeu:   branch = ($signed(A) > $signed(B));
            default: branch = 0;
        endcase
    end
    
endmodule
