module mux3to1 (
    input [31:0] in0,
    input [31:0] in1,
    input [31:0] in2,
    input [1:0] sel,
    output [31:0] out
);
   assign out = (sel[1]) ? (sel[0] ? 32'b0 : in2) : (sel[0] ? in1 : in0);
endmodule