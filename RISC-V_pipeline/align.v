module align (
    input [31:0] in,
    input [2:0] load_sel_M,
    input [1:0] offset,
    output reg [31:0] out
);
    always @(*) begin
        case (load_sel_M)
            3'b000: begin
                if (offset == 2'b00)    out <= {{24{in[7]}}, in[7:0]};
                else if (offset == 2'b01) out <= {{24{in[15]}}, in[15:8]};
                else if (offset == 2'b10) out <= {{24{in[23]}}, in[23:16]};
                else                      out <= {{24{in[31]}}, in[31:24]};   
            end 
            3'b001: begin
                if (offset == 2'b00) out <= {{16{in[15]}}, in[15:0]};
                else                 out <= {{16{in[31]}}, in[31:15]};
            end
            3'b010: begin
                out <= in [31:0];   
            end
            3'b100: begin
                if (offset == 2'b00)      out <= {24'b0, in[7:0]};
                else if (offset == 2'b01) out <= {24'b0, in[15:8]};
                else if (offset == 2'b10) out <= {24'b0, in[23:16]};
                else                      out <= {24'b0, in[31:24]};  
            end
            3'b101: begin
                if (offset == 2'b00) out <= {16'b0, in[15:0]};
                else                 out <= {16'b0, in[31:15]};
            end
            default: out <= in;
        endcase
    end
endmodule