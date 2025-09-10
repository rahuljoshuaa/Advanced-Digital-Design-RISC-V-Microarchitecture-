`timescale 1ns / 1ps  
`include "program_counter.sv"

module program_counter_tb;
    logic clk;
    logic reset;
    logic [31:0] PCNext;
    logic [31:0] PC;

    program_counter uut (
        .clk(clk),
        .reset(reset),
        .PCNext(PCNext),
        .PC(PC)
    );

    initial begin
        clk = 0;
    end
    always #10 clk = ~clk;  

    initial begin
        reset = 1;
        #100;
        $display("Time=%0d | PC=%h | PCNext=%h | Reset=%b", $time, PC, PCNext, reset);
        PCNext = 32'h00000004;
        #20 reset = 0;  

        repeat (6) begin
            #20;
            $display("Time=%0d | PC=%h | PCNext=%h | Reset=%b", $time, PC, PCNext, reset);
            PCNext = PCNext + 4;
        end

        #100 $finish;  
    end

    initial begin
        $dumpfile("program_counter_tb.vcd");
        $dumpvars(0, program_counter_tb);
    end
endmodule
