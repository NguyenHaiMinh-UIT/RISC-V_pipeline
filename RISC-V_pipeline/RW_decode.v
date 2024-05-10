module RW_decode (
    input [2:0] store_sel_M,
    input [2:0] load_sel_M,
    output reg m_rnw
);
    always @(*) begin
        if (load_sel_M == 3'b111 && store_sel_M == 3'b111) 
            m_rnw = 1'bx;
        else if (load_sel_M!= 3'b111 && store_sel_M == 3'b111)
            m_rnw =  1;
        else if (load_sel_M == 3'b111 && store_sel_M != 3'b111)
            m_rnw = 0;
        else m_rnw = 1'bx;
    end
endmodule