![e262bdd1ac6785945441cd012db8f71](https://github.com/user-attachments/assets/0d6dd000-e09b-4480-8ab6-059bf75c59b0)
![image](https://github.com/user-attachments/assets/2cf2e30a-955e-40f1-b7b9-f0e41387a699)

# RF & Microwave System (2024 Fall, Senior Year First Semester)

This repository contains materials from the graduate-level course **"RF & Microwave System"**, taken in Fall 2024 during the first semester of the senior year. The course project focused on the development and testing of a 2.4 GHz frequency-modulated continuous wave (FMCW) radar system.

## Reference Links
- [Course Introduction](https://music-sustech.github.io/education/sme5029-eec134.html)
- [Course GitHub Repository](https://github.com/ucdart/UCD-EEC134/)

These links are references to the original course materials set up by Professor Liu at UC Davis.

---

## Contents

### IEEE-Formatted Lab Reports
To make the reports more accessible, I have consolidated IEEE conference-style formatted reports on the main page. The reports include:
  - **Lab1_Report.pdf**: Baseband Circuit System
  - **Lab2_Report.pdf**: Characterization of RF Amplifiers
  - **Lab3_Report.pdf**: Voltage Controlled Oscillators
  - **Lab4_Report.pdf**: Characterization of RF Mixers
  - **Lab5_Report.pdf**: Antenna Design
  - **Lab6_Report.pdf**: Final report. Assembly and testing of the Radar System

---

### Lab Folders
Each lab folder contains:
- The corresponding **lab requirements** and **materials**.
- Supporting **code** and **design files** for the lab tasks.

---

### Code
- A `reference_code/` folder includes all the Python scripts and additional implementation details used for:
  - Data processing (e.g., FFT analysis).
  - Component testing.
  - Radar system functionality.
 
---
## Project Overview

The project involved the following key steps:
1. **Component Testing and Characterization**:
   - PA (Power Amplifier)
   - LNA (Low Noise Amplifier)
   - Mixer
   - VCO (Voltage-Controlled Oscillator)
   - Custom-made tea-can antenna

2. **Baseband Circuit Implementation**:
   - Waveform generator using a microcontroller (Teensy 4.0) and DAC IC: The programming of Teensy 4.0 is done in the Arduino IDE (Integrated Development Environment).
   - Active low-pass filter (LPF) with adjustable gain.

3. **Data Acquisition and Processing**:
   - Data collected using Analog Discovery as an oscilloscope.
   - Processed in Python for FFT and other analyses.

### Outcome
This workflow successfully enabled the detection of both stationary and moving targets, demonstrating the functionality of the FMCW radar system.


