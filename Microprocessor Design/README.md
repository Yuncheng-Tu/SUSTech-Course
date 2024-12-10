# Microprocessor Design (2023 Fall, Junior Year First Semester)

This repository contains the final project and lab materials for the course **"Microprocessor Design"**, taken in Fall 2023 during the first semester of the junior year. The project involves implementing and extending processor architectures, as well as developing features based on ARM and RISC-V ISAs. Detailed project requirements are provided in the `Final_Project_Requirement.docx`.

## Project Overview

### Final Project
The final project includes:
1. **Code**:
   - Implemented in both RTL and assembly languages.
   - Covers ARM and RISC-V architectures.
   - Code files are stored in the `code/` folder.

2. **Report**:
   - A comprehensive report describing the final project implementation, currently in Chinese.
   - Includes details on processor design and testing.
   - The report format is flexible but highlights critical hardware design aspects.
   - File: `Final_Project_Report.pdf`

3. **Requirements**:
   - Detailed project guidelines are available in the `Final_Project_Requirement.docx` file located in the `Final Project` folder.

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

---

## Additional Notes
- **Code**:
  - All source code, testbenches, and configuration files are included in the respective lab folders.
  - Final project code is organized in the `code/` folder.

- **Documentation**:
  - The `Final_Project_Requirement.docx` provides detailed guidelines for the final project.

Feel free to explore the repository for reference or learning purposes!

