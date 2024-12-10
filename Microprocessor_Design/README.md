# Microprocessor Design (2023 Fall, Junior Year First Semester)

This repository contains the final project and lab materials for the course **"Microprocessor Design"**, taken in Fall 2023 during the first semester of the junior year. The project involves implementing and extending processor architectures, as well as developing features based on ARM and RISC-V ISAs. Detailed project requirements are provided in the `SME309 Final_Project_Requirements_2023.pdf`.

## Final Project: Advanced Processor Design

The final project for the course **"Microprocessor Design" (2023 Fall)** focuses on implementing and enhancing processor architectures, with detailed requirements for ARM and RISC-V ISAs. This project demonstrates advanced concepts in microprocessor design through pipeline implementation, instruction set expansion, and memory hierarchy integration.

**Note**: The final project report is currently written in Chinese with a flexible format. It is available as `Report_Final_Project(Chinese).pdf` in the `Final Project` folder.

### Project Components

1. **Five-Stage Pipeline Processor with Hazard Unit** 
   - **Objective**: Design and implement a five-stage pipeline processor based on the single-cycle processor developed in Lab 2.
   - **Features**:
     - Handle data hazards (data forwarding, stall, flush).
     - Manage control hazards (early branch target address (BTA), flush).
   - **Validation**:
     - Develop testbenches and assembly code to verify pipeline functionality using simulation waveforms.

2. **Non-Stalling CPU for Multi-Cycle Instructions** 
   - **Objective**: Enable the processor to execute subsequent instructions without stalling the pipeline during multi-cycle instruction execution (e.g., `MUL`).
   - **Features**:
     - Allow independent instructions without dependencies to proceed.
     - Introduce pipeline stalls only when data dependencies exist.
   - **Validation**:
     - Write and simulate assembly code to verify functionality.

3. **Expand ARM Processor to Support 16 Data Processing Instructions** 
   - **Objective**: Enhance the ARM processor to include all 16 data processing instructions as described in the ARM Architecture Reference Manual (Section A3.4).
   - **Features**:
     - Modify the ALU and ALU decoder in the control unit.
     - Integrate the `C` flag into the `CondiLogic` and `ALU` modules for additional instructions like `ADC`.
   - **Validation**:
     - Simulate new instructions and validate with testbench results.

4. **4-Way Set Associative Cache Integration** 
   - **Objective**: Implement a 4KB, 4-way set associative cache between memory and the ARM CPU.
   - **Features**:
     - Support write-allocate and write-back strategies.
     - Handle four scenarios:
       1. Read hit: Load data directly from cache to register.
       2. Read miss: Load from memory to cache, then to register.
       3. Write hit: Write to cache and set the block dirty.
       4. Write miss: Handle dirty block write-back or direct memory write.
   - **Validation**:
     - Test with assembly code covering all cache access scenarios.

5. **Floating-Point Unit (FPU)** 
   - **Objective**: Add an FPU to support basic floating-point instructions (`FADD`, `FMUL`) in the ARM CPU pipeline.
   - **Features**:
     - Address floating-point operations.
     - Handle special cases, such as NaN values.
   - **Validation**:
     - Test with custom assembly programs and include design details in the report.

6. **RISC-V ISA Implementation** 
   - **Objective**: Implement a single-cycle CPU core supporting basic RISC-V instructions from the RV32I extension.
   - **Features**:
     - Support integer computation, load/store, and control transfer instructions.
     - Explore differences between ARM and RISC-V hardware architectures.
   - **Validation**:
     - Test with assembly programs for all implemented instructions.

### Bonus Tasks 
Optional advanced features to improve processor performance:
   - Dynamic Branch Prediction.
   - Multiple-Issue (Superscalar) Architecture.
   - Out-of-Order Execution.
   - Interrupt and Exception Handling.

### Report Guidelines
- **Structure**: Flexible, but must clearly detail each task and highlight critical hardware design decisions.
- **Submission Requirements**:
  - Well-formatted PDF report (including waveforms and FPGA validation results).
  - Source code ZIP (RTL files, assembly code, testbenches).
  - Constraints and other auxiliary files.



---

## Labs

### Lab 1: Familiarization with Keil MDK and Vivado
- **Objective**: 
  - Develop familiarity with FPGA development tools, including Keil MDK and Vivado.
  - Understand how to create and display ROM (Read-Only Memory) contents using FPGA.

- **Tasks**:
  1. **Create ROMs**:
     - Implement an **Instruction ROM** and a **Data ROM** in RTL code.
     - Populate these ROMs with predefined values.
  2. **Display ROM Content**:
     - Use **LED lights** on the FPGA board to display the ROM addresses.
     - Use a **7-segment display** to show the memory content at the specified addresses.

- **Expected Outcome**:
  - Successfully display ROM addresses and content on the FPGA board using the specified hardware.

---

### Lab 2: Implementation of an ARMv3 Processor (FPGA Verification)
- **Objective**:
  - Implement a simplified ARMv3 processor on an FPGA, supporting a set of memory, data-processing, and branch instructions.
  - Extend the processor to handle additional features.

- **Tasks**:
  1. **Basic Implementation**:
     - Support the following instructions:
       - **Memory Instructions**:
         - LDR, STR (positive immediate offset, e.g., `LDR R6, [R4, #4]`).
       - **Data-Processing Instructions**:
         - AND, OR, ADD, SUB (register or immediate `Scr2`, no shifts, e.g., `ADD R9, R8, R5` or `SUB R3, R11, #1`).
       - **Branch Instruction**:
         - B.
  2. **Feature Enhancements**:
     - Extend the processor to support:
       - **Memory Instructions**:
         - LDR, STR (negative immediate offset, e.g., `STR R6, [R4, #-4]`).
       - **Data-Processing Instructions**:
         - CMP, CMN.
       - **Shift Operations**:
         - Add Src2 register support with immediate shift operations: **LSL**, **LSR**, **ASR**, **ROR** (e.g., `ADD R7, R2, R12, LSR #5`).

- **Expected Outcome**:
  - The ARMv3 processor is validated on FPGA, successfully executing all the specified instructions.

---

### Lab 3: Unsigned Multiplication & Division Unit (FPGA Verification)
- **Objective**:
  - Design and implement a multi-cycle unit, “Mcycle,” for **unsigned multiplication** and **division**.
  - Extend the processor to support new instructions.

- **Tasks**:
  1. **Multiplication**:
     - Improve the provided multiplier template to reduce hardware resource utilization.
     - Design a multi-cycle unsigned multiplication module.
  2. **Division**:
     - Share the hardware resources with the multiplication module to implement division.
     - Design a custom unsigned division instruction with decoding logic.
  3. **Integration**:
     - Add the `Mcycle` module to the existing single-cycle processor to support:
       - The `MUL` instruction (ARM Reference Manual A4-66).
       - A custom unsigned division instruction (not directly implemented in the ARM instruction set).
  4. **Testing**:
     - Simulate the functionality using a testbench.
     - Verify the correctness against the provided waveform.

- **Expected Outcome**:
  - A fully functional `Mcycle` unit integrated into the processor, successfully handling both `MUL` and the custom division instruction.





