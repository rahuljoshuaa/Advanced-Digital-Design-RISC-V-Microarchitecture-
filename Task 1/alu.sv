module alu (
    input logic signed [31:0] A,         
    input logic signed [31:0] B,         
    input logic [4:0] ALUControl, 
    output logic [31:0] ALUResult, 
    output logic Zero,
    output logic Negative
);

    logic [4:0] B_shift;  
    assign B_shift = B[4:0];

    always_comb begin
        casex (ALUControl)
            5'b0xx00: ALUResult = A << B_shift;   
            5'b1xx00: ALUResult = A >> B_shift;  
            5'bx0x10: ALUResult = A + B;        
            5'bx1x10: ALUResult = A - B;        
            5'bxx011: ALUResult = A & B;        
            5'bxx111: ALUResult = A | B;       
            5'bxxx01: ALUResult = (A < B) ? 32'b1 : 32'b0;  
            default: ALUResult = 32'b0;         
        endcase
    end

    assign Zero = (ALUResult == 32'b0) ? 1'b1 : 1'b0;
    assign Negative = ALUResult[31];
    
endmodule
