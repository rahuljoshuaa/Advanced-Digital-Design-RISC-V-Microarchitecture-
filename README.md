# Advanced Digital Design RISC-V Microarchitecture

## Overview  
This project focuses on the **design, simulation, and verification of a single-cycle RISC-V CPU** using SystemVerilog. It demonstrates the creation of a hierarchical CPU design, simulation of individual modules and the complete processor, and testing with custom RISC-V assembly programs.  

The main goals achieved include:  
- Implementing a **RISC-V CPU** in SystemVerilog with modular hierarchy  
- Simulating and debugging components using **Icarus Verilog** and **GTKWave**  
- Developing and verifying **RISC-V assembly programs** for arithmetic, branching, and memory operations  

---

## Block Diagram of the Designed RISC-V CPU  

![Figure 1: Block diagram of the designed RISC-V CPU](figure1.png)  

![Figure 2: Arithmetic Logic Unit (ALU) internal design](figure2.png)  

---

## Instruction Formats and Subset of RV32I Instructions  

### Table 1: RISC-V Instruction Formats  
![Table 1](table1.png)  

### Table 2: Supported Subset of RV32I Base Instructions  
![Table 2](table2.png)  

### Table 3: ImmSrc Control Signals and Immediate Extensions  
![Table 3](table3.png)  

---

## Project Structure  

### SystemVerilog Modules  
- `program_counter.sv` – Manages program flow  
- `instruction_memory.sv` – Stores the machine code program  
- `control_unit.sv` – Decodes instructions and generates control signals  
- `reg_file.sv` – Implements the register file  
- `extend.sv` – Performs immediate value extension  
- `alu.sv` – Executes arithmetic and logic operations  
- `data_memory_and_io.sv` – Handles data memory and I/O  
- `risc_v.sv` – Top-level module integrating all components  

### Testbenches  
- `program_counter_tb.sv`  
- `control_unit_tb.sv`  
- `extend_tb.sv`  
- `alu_tb.sv`  
- `risc_v_tb.sv` (top-level testbench)  

### Assembly Programs  
- `count_ones.s` – Counts the number of `1`s in the least significant byte of CPUIn  
- `multiply_shift_add.s` – Multiplies two 8-bit values using shift-and-add  

---

## Tools Used  
- **Icarus Verilog** – Compiling and simulating SystemVerilog code  
- **GTKWave** – Viewing simulation waveforms  
- **VS Code** – Development environment  

---

## Deliverables  
- Full SystemVerilog source code  
- RISC-V assembly code listings  
- Simulation results (waveforms, logs)  
- Analysis and verification of CPU functionality  

---

## Instructions to Run  
1. Place `program.txt` (machine code) and assembly `.s` files in the same directory as the modules.  
2. Compile and simulate using **Icarus Verilog**.  
3. Open the `.vcd` files in **GTKWave** to visualize waveforms.  

---

## Author  
**Name:** Dylan Lim  
**Institution:** University College London (UCL)  
