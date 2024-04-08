module mux4to1 (
    input [31:0] in0,
    input [31:0] in1,
    input [31:0] in2,
    input [31:0] in3,
    input [1:0] sel,
    output [31:0] out
);
    // always @(*) begin
    //     case (sel)
    //         0'b00: out <= in0;
    //         0'b01: out <= in1;
    //         0'b10: out <= in2;
    //         0'b11: out <= in3; 
    //         default: out <= 32'bx;
    //     endcase
    // end
    assign out = (sel[1]) ? (sel[0] ? in3 : in2) : (sel[0] ? in1 : in0) ;
endmodule