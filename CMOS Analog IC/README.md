# CMOS Analog IC Folder

This folder contains the detailed design process and results of a **Two-Stage Differential CMOS Operational Amplifier**, documented in the report `CMOS_analog_IC_report.pdf`. The report is formatted in the style of an IEEE conference paper and provides an in-depth analysis of the design methodologies, trade-offs, and performance evaluations.

---

## Project Overview

### Final Design
- **Objective**:
  - Design a **Two-Stage Differential CMOS Operational Amplifier** using **0.18 µm CMOS technology** to meet stringent performance requirements, including:
    - High open-loop gain.
    - Wide bandwidth.
    - Low power consumption.
    - High slew rate.
    - Stability across a ±10% supply voltage variation.
- **Design Methodology**:
  - The amplifier was designed using the **gm/Id** design methodology
- **Key Challenges Addressed**:
  - **Stability**: Designed to achieve adequate phase margin, resolving issues related to stability in multi-stage architectures.
  - **Trade-Offs**: Balanced gain, bandwidth, and power consumption while addressing PVT (Process, Voltage, Temperature) variations.

---

### Exploration and Iteration
We explored several classic architectures during the design process, including:
1. **OTA-Based Designs**:
   - Used as an initial stage to boost differential gain.
2. **Folded-Cascode and Telescopic Structures**:
   - Investigated self-biased folded cascode stages cascaded with CS stages for high gain and improved output swing.
   - **Note**: These structures were not included in the final report.
3. **Three-Stage Amplifiers**:
   - Experimented with a fully differential folded cascode-source follower-OTA design to achieve optimal amplification performance, though significant stability challenges arose due to phase margin issues.

Through iterative testing and refinement, we ultimately opted for a **two-stage architecture**, which effectively balanced performance metrics while ensuring stability.

---

### Reflections
This project deepened my understanding of core circuit design principles and highlighted the complexity of achieving stability and performance in analog circuits. Key takeaways include:
- Recognizing the intricate trade-offs between gain, bandwidth, and power consumption.
- Understanding the impact of PVT variations and the importance of robust compensation techniques.
- Developing a critical appreciation for the iterative process in analog IC design.

**Note**: The report focuses on the final two-stage design and does not include the intermediate designs, such as the three-stage amplifier or detailed folded cascode structures.

