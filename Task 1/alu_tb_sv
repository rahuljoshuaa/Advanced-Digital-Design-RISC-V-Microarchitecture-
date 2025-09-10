`timescale 1ns / 1ps
`include "alu.sv"

module alu_tb;
    logic [31:0] A;
    logic [31:0] B;
    logic [4:0] ALUControl;
    logic [31:0] ALUResult;
    logic Zero, Negative;

    alu uut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),
        .Zero(Zero),
        .Negative(Negative)
    );

    initial begin
        $dumpfile("alu_tb.vcd");
        $dumpvars(0, alu_tb);
        $display("Time(ns) | ALUControl | A         | B         | ALUResult | Zero | Negative");
        $display("--------------------------------------------------------------------------");

        A = 32'h00000005; B = 32'h00000002; ALUControl = 5'b00000; 
        #10 $display("%0d  | %5b      | %b | %b | %b | %b | %b", $time, ALUControl, A, B, ALUResult, Zero, Negative);

        A = 32'h00000005; B = 32'h00000002; ALUControl = 5'b10000; 
        #10 $display("%0d  | %5b      | %b | %b | %b | %b | %b", $time, ALUControl, A, B, ALUResult, Zero, Negative);

        A = 32'h00000005; B = 32'h00000002; ALUControl = 5'b01001; 
        #10 $display("%0d  | %5b      | %b | %b | %b | %b | %b", $time, ALUControl, A, B, ALUResult, Zero, Negative);

        A = 32'h00000005; B = 32'h00000002; ALUControl = 5'b00010; 
        #10 $display("%0d  | %5b      | %b | %b | %b | %b | %b", $time, ALUControl, A, B, ALUResult, Zero, Negative);

        A = 32'h00000002; B = 32'h00000005; ALUControl = 5'b01111; 
        #10 $display("%0d  | %5b      | %b | %b | %b | %b | %b", $time, ALUControl, A, B, ALUResult, Zero, Negative);

        A = 32'h00000005; B = 32'h00000002; ALUControl = 5'b01010; 
        #10 $display("%0d  | %5b      | %b | %b | %b | %b | %b", $time, ALUControl, A, B, ALUResult, Zero, Negative);

        A = 32'h00000002; B = 32'h00000005; ALUControl = 5'b01011; 
        #10 $display("%0d  | %5b      | %b | %b | %b | %b | %b", $time, ALUControl, A, B, ALUResult, Zero, Negative);
        #10 $finish;
    end
endmodule
