![image](https://github.com/user-attachments/assets/2f04af73-7121-472f-bb38-218302320fad)
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

