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
