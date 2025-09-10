`include "program_counter.sv"
`include "control_unit.sv"
`include "extend.sv"
`include "alu.sv"
`include "data_memory_and_io.sv"
`include "instruction_memory.sv"
`include "reg_file.sv"

module risc_v (
    input logic CLK,
    input logic Reset,
    input logic [31:0] CPUIn,
    output logic [31:0] CPUOut
);

    logic [31:0] PC, PCNext, PCPlus4, Result, BranchTarget, JalTarget, JalrTarget, xx18;   
    logic signed [31:0] PCTarget;
    logic [31:0] Instr;                           
    logic [31:0] RD1, RD2, ALUResult, ImmExt;     
    logic [31:0] WD3, WD, RD, SrcA, SrcB;      
    logic Zero, Negative;                         
    logic MemWrite, ALUSrc, WE;                   
    logic [4:0] ALUControl;                       
    logic [2:0] ImmSrc;                           
    logic [1:0] ResultSrc, PCSrc;                 
    logic WE3, WE_MEM;                            


    program_counter PC_module (
        .clk(CLK),
        .reset(Reset),
        .PCNext(PCNext),
        .PC(PC)
    );

    assign PCTarget = (PCSrc == 2'b01) ? BranchTarget :
                      (PCSrc == 2'b10) ?
                      ((Instr[6:0] == 7'b1101111) ? JalTarget : 
                       (Instr[6:0] == 7'b1100111) ? JalrTarget : 32'hXXXXXXXX)
                  : 32'hXXXXXXXX;

    assign PCNext = (PCSrc == 2'b00) ? PCPlus4 :
                    (PCSrc == 2'b01) ? PCTarget :
                    (PCSrc == 2'b10) ? ALUResult :
                    PCPlus4;

    assign BranchTarget = PC + ImmExt;
    assign JalTarget = PC + ImmExt;
    assign JalrTarget = ALUResult;

    assign PCPlus4 = PC + 4;

    instruction_memory IM_module (
        .Instr(Instr),
        .PC(PC)
    );

    control_unit CU_module (
        .Instr(Instr),
        .RegWrite(WE),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .PCSrc(PCSrc),
        .ImmSrc(ImmSrc),
        .ALUControl(ALUControl),
        .Zero(Zero),
        .Negative(Negative)
    );

    reg_file RF_module (
        .RD1(RD1),
        .RD2(RD2),
        .WD3(WD3),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .WE3(WE3),
        .CLK(CLK)
    );

    assign SrcA = RD1;
    assign SrcB = (ALUSrc) ? ImmExt : RD2;
    
    extend EXT_module (
        .Instr(Instr),
        .ImmSrc(ImmSrc),
        .ImmExt(ImmExt)  
    );

    logic [4:0] A1, A2, A3;
    assign WE3 = WE;
    assign A1 = Instr[19:15];
    assign A2 = Instr[24:20];
    assign A3 = Instr[11:7];

    alu ALU_module (
        .A(SrcA),
        .B(SrcB),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),  
        .Zero(Zero),
        .Negative(Negative)
    );

    assign A = ALUResult;
    assign WD = RD2;
    assign WE_MEM = MemWrite;

    data_memory_and_io DM_module (
        .RD(RD),
        .CPUOut(CPUOut),  
        .A(ALUResult),
        .WD(WD),
        .CPUIn(CPUIn),
        .WE(WE_MEM),
        .CLK(CLK)
    );

    assign Result = (ResultSrc == 2'b00) ? ImmExt :
                 (ResultSrc == 2'b01) ? ALUResult :
                 (ResultSrc == 2'b10) ? RD :
                 PCPlus4;
    
    assign WD3 = Result;

endmodule
