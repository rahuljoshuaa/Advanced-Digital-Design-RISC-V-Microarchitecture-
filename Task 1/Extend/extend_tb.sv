`timescale 1ns / 1ps
`include "extend.sv"

module extend_tb;
    logic [31:0] Instr;
    logic [2:0] ImmSrc;
    logic [31:0] ImmExt;

    extend uut (
        .Instr(Instr),
        .ImmSrc(ImmSrc),
        .ImmExt(ImmExt)
    );

    initial begin
        $dumpfile("extend_tb.vcd");
        $dumpvars(0, extend_tb);

        $display("Time(ns) | ImmSrc | Instr      | ImmExt");
        $display("---------------------------------------------");

        #10 Instr = 32'hFEDCBA98; ImmSrc = 3'b000;  
        #1  $display("%0d | %3b | %h | %h", $time, ImmSrc, Instr, ImmExt);

        #10 Instr = 32'h12345678; ImmSrc = 3'b001;  
        #1  $display("%0d | %3b | %h | %h", $time, ImmSrc, Instr, ImmExt);

        #10 Instr = 32'h87654321; ImmSrc = 3'b010; 
        #1  $display("%0d | %3b | %h | %h", $time, ImmSrc, Instr, ImmExt);

        #10 Instr = 32'hABCDEF12; ImmSrc = 3'b011; 
        #1  $display("%0d | %3b | %h | %h", $time, ImmSrc, Instr, ImmExt);
 
        #10 Instr = 32'hABCDE123; ImmSrc = 3'b100;  
        #1  $display("%0d | %3b | %h | %h", $time, ImmSrc, Instr, ImmExt);

        #10 $finish;
    end
endmodule
