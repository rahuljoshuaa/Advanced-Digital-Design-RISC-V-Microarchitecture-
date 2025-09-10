module control_unit (
    output logic RegWrite, ALUSrc, MemWrite,
    output logic [1:0] ResultSrc,
    output logic [1:0] PCSrc,
    output logic [2:0] ImmSrc,
    output logic [4:0] ALUControl,
    input logic [31:0] Instr,
    input logic Zero, Negative);

logic[6:0] opcode;
logic[2:0] funct3;
logic[6:0] funct7;

assign opcode = Instr[6:0];
assign funct3 = Instr[14:12];
assign funct7 = Instr[31:25];

always_comb begin 
    case(opcode) 
        7'b0110011: begin  
            RegWrite = 1;
            ImmSrc = 3'bxxx;
            ALUSrc = 0;
            MemWrite = 0;
            ResultSrc = 2'b01;
            PCSrc = 2'b00;
                
            case (funct3)
                3'b000: ALUControl = (funct7 == 7'b0100000) ? 5'bx1x10 : 5'bx0x10; // SUB / ADD
                3'b110: ALUControl = 5'bxx111; // OR
                3'b111: ALUControl = 5'bxx011; // AND
                3'b001: ALUControl = 5'b0xx00; // SLL
                3'b101: ALUControl = 5'b1xx00; // SRL
                3'b010: ALUControl = 5'bx1x01; // SLT         
            endcase
        end

        7'b0010011: begin  
            RegWrite = 1;
            ImmSrc = 3'b000;
            ALUSrc = 1;
            MemWrite = 0;
            ResultSrc = 2'b01;
            PCSrc = 2'b00;

            case (funct3)
                3'b000: ALUControl = 5'bx0x10; // ADDI
                3'b110: ALUControl = 5'bxx111; // ORI
                3'b111: ALUControl = 5'bxx011; // ANDI
                3'b001: ALUControl = 5'b0xx00; // SLLI
                3'b101: ALUControl = 5'b1xx00; // SRLI
                3'b010: ALUControl = 5'bx1x01; // SLTI
            endcase
        end

        7'b0000011: begin  // Load Word (LW)
            RegWrite = 1;
            ImmSrc = 3'b000;
            ALUSrc = 1;
            MemWrite = 0;
            ResultSrc = 2'b10;
            PCSrc = 2'b00;
            ALUControl = 5'bx0x10;
        end

        7'b0100011: begin  // Store Word (SW)
            RegWrite = 0;
            ImmSrc = 3'b001;
            ALUSrc = 1;
            MemWrite = 1;
            ResultSrc = 2'b01;
            PCSrc = 2'b00;
            ALUControl = 5'bx0x10;
        end

        7'b1100011: begin  // Branch
            RegWrite = 0;
            ImmSrc = 3'b010;
            ALUSrc = 0;
            MemWrite = 0;
            ResultSrc = 2'bxx;
            ALUControl = 5'bx1x10;

            case (funct3)
                3'b000: PCSrc = (Zero) ? 2'b01 : 2'b00; // BEQ: Branch if Zero
                3'b001: PCSrc = (Zero) ? 2'b00 : 2'b01; // BNE: Branch if not Zero
                3'b100: PCSrc = (Negative) ? 2'b01 : 2'b00; // BLT: Branch if less than
                3'b101: PCSrc = (Negative) ? 2'b00 : 2'b01; // BGE: Branch if greater or equal
            endcase
        end

        7'b1101111: begin  // JAL
            RegWrite = 1;
            ImmSrc = 3'b100;
            ALUSrc = 0;
            MemWrite = 0;
            ResultSrc = 2'b11;
            PCSrc = 2'b01;
            ALUControl = 5'bxxxxx;
        end

        7'b1100111: begin  // JALR
            RegWrite = 1;
            ImmSrc = 3'b000;
            ALUSrc = 1;
            MemWrite = 0;
            ResultSrc = 2'b11;
            PCSrc = 2'b10;
            ALUControl = 5'bX0X10;
        end

        7'b0110111: begin  // LUI
            RegWrite = 1;
            ImmSrc = 3'b011;
            ALUSrc = 0;
            MemWrite = 0;
            ResultSrc = 2'b00;
            PCSrc = 2'b00;
            ALUControl = 5'bxxxxx;
        end

    endcase

end

endmodule
