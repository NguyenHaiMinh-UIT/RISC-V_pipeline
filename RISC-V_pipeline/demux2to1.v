module demux2to1 (
    input [31:0] in,
    input sel,
    output [4:0] out0,
    output [31:0] out1
);
    assign out0 = sel ? 32'b0 : in[4:0];
    assign out1 = sel ? in : 32'b0; 
endmodule 