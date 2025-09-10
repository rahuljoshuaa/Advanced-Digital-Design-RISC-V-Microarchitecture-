`timescale 1ns / 1ps
`include "risc_v.sv"

module risc_v_tb;
    logic CLK;
    logic Reset;
    logic [31:0] CPUIn;
    logic [31:0] CPUOut;

    risc_v uut (
        .CLK(CLK),
        .Reset(Reset),
        .CPUIn(CPUIn),
        .CPUOut(CPUOut)
    );

    initial begin
        CLK = 0;
    end
    always #10 CLK = ~CLK;  

    initial begin
    CPUIn = 131;  
    Reset = 1;  
    #20;  
     
    #80;
    $display("Time=%0d | CPUIn=%b | CPUOut=%h | Reset=%b | PCSrc=%b | PC=%d | PCTarget=%h | ImmExt=%h | Instr=%h | ALUResult=%d", 
             $time, CPUIn, CPUOut, Reset, uut.PCSrc, uut.PC, uut.PCTarget, uut.ImmExt, uut.Instr, uut.ALUResult);
    
    #10 Reset = 0;  
    for (int i = 0; i < 57; i++) begin  
        #20;
        $display("Time=%0d | CPUIn=%b | CPUOut=%h | Reset=%b | PCSrc=%b | PC=%d | PCTarget=%h | ImmExt=%h | Instr=%h | ALUResult=%d", 
                 $time, CPUIn, CPUOut, Reset, uut.PCSrc, uut.PC, uut.PCTarget, uut.ImmExt, uut.Instr, uut.ALUResult);
    end
    
    #100 $finish;
end

    initial begin
        $dumpfile("risc_v_tb.vcd");
        $dumpvars(0, risc_v_tb);
    end
endmodule
