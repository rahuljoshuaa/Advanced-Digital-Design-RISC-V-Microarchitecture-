module program_counter (
    input logic clk,             
    input logic reset,           
    input logic [31:0] PCNext,   
    output logic [31:0] PC       
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            PC <= 32'b0; 
        else
            PC <= PCNext; 
    end

endmodule
