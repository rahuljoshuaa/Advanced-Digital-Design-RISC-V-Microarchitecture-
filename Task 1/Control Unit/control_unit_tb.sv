`timescale 1ns / 1ps
`include "control_unit.sv"

module control_unit_tb;
    logic [31:0] Instr;
    logic RegWrite, ALUSrc, MemWrite;
    logic [1:0] ResultSrc, PCSrc;
    logic [2:0] ImmSrc, funct3;
    logic [4:0] ALUControl;
    logic [6:0] opcode, funct7;
    logic Zero, Negative;

    control_unit uut (
        .Instr(Instr),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .PCSrc(PCSrc),
        .ImmSrc(ImmSrc),
        .ALUControl(ALUControl),
        .Zero(Zero),
        .Negative(Negative)
    );

    assign opcode = Instr[6:0];
    assign funct3 = Instr[14:12];
    assign funct7 = Instr[31:25];

    initial begin
        $display("Opcode  | Funct3 | Funct7  | RegWrite | ImmSrc | ALUSrc | ALUControl | MemWrite | ResultSrc | PCSrc");
        $display("------------------------------------------------------------------------------------------------");

        // R-type (ADD)
        Instr = {7'b0000000, 5'b00001, 5'b00010, 3'b000, 5'b00011, 7'b0110011}; #10;
        $display("%7b | %3b   | %7b  | %b       | %3b    | %b      | %5b       | %b        | %2b       | %2b", 
                 opcode, funct3, funct7, RegWrite, ImmSrc, ALUSrc, ALUControl, MemWrite, ResultSrc, PCSrc);

        // I-type (ADDI)
        Instr = {12'b000000000101, 5'b00001, 3'b000, 5'b00010, 7'b0010011}; #10;
        $display("%7b | %3b   | %7b  | %b       | %3b    | %b      | %5b       | %b        | %2b       | %2b", 
                 opcode, funct3, funct7, RegWrite, ImmSrc, ALUSrc, ALUControl, MemWrite, ResultSrc, PCSrc);

        // Load Word (LW)
        Instr = {12'b000000000101, 5'b00001, 3'b010, 5'b00010, 7'b0000011}; #10;
        $display("%7b | %3b   | %7b  | %b       | %3b    | %b      | %5b       | %b        | %2b       | %2b", 
                 opcode, funct3, funct7, RegWrite, ImmSrc, ALUSrc, ALUControl, MemWrite, ResultSrc, PCSrc);

        // Store Word (SW)
        Instr = {7'b0000000, 5'b00001, 5'b00010, 3'b010, 5'b00011, 7'b0100011}; #10;
        $display("%7b | %3b   | %7b  | %b       | %3b    | %b      | %5b       | %b        | %2b       | %2b", 
                 opcode, funct3, funct7, RegWrite, ImmSrc, ALUSrc, ALUControl, MemWrite, ResultSrc, PCSrc);

        // Branch (BEQ)
        Instr = {7'b0000000, 5'b00001, 5'b00010, 3'b000, 5'b00011, 7'b1100011}; 
        Zero = 1; #10;  
        $display("%7b | %3b   | %7b  | %b       | %3b    | %b      | %5b       | %b        | %2b       | %2b", 
                 opcode, funct3, funct7, RegWrite, ImmSrc, ALUSrc, ALUControl, MemWrite, ResultSrc, PCSrc);

        // Branch (BNE)
        Instr = {7'b0000000, 5'b00001, 5'b00010, 3'b001, 5'b00011, 7'b1100011}; 
        Zero = 0; #10;  
        $display("%7b | %3b   | %7b  | %b       | %3b    | %b      | %5b       | %b        | %2b       | %2b", 
                 opcode, funct3, funct7, RegWrite, ImmSrc, ALUSrc, ALUControl, MemWrite, ResultSrc, PCSrc);

        // Jump (JAL)
        Instr = {20'b00000000000000000001, 5'b00001, 7'b1101111}; #10;
        $display("%7b | %3b   | %7b  | %b       | %3b    | %b      | %5b       | %b        | %2b       | %2b", 
                 opcode, funct3, funct7, RegWrite, ImmSrc, ALUSrc, ALUControl, MemWrite, ResultSrc, PCSrc);

        // Jump Register (JALR)
        Instr = {12'b000000000101, 5'b00001, 3'b000, 5'b00010, 7'b1100111}; #10;
        $display("%7b | %3b   | %7b  | %b       | %3b    | %b      | %5b       | %b        | %2b       | %2b", 
                 opcode, funct3, funct7, RegWrite, ImmSrc, ALUSrc, ALUControl, MemWrite, ResultSrc, PCSrc);

        // Load Upper Immediate (LUI)
        Instr = {20'b00000000000000000001, 5'b00001, 7'b0110111}; #10;
        $display("%7b | %3b   | %7b  | %b       | %3b    | %b      | %5b       | %b        | %2b       | %2b", 
                 opcode, funct3, funct7, RegWrite, ImmSrc, ALUSrc, ALUControl, MemWrite, ResultSrc, PCSrc);

        #10 $finish;
    end
endmodule
