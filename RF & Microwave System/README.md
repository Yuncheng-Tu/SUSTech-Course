# RF & Microwave System (2024 Fall, Senior Year First Semester)

This repository contains materials from the graduate-level course **"RF & Microwave System"**, taken in Fall 2024 during the first semester of the senior year. The course project focused on the development and testing of a 2.4 GHz frequency-modulated continuous wave (FMCW) radar system.

## Project Overview

The project involved the following key steps:
1. **Component Testing and Characterization**:
   - PA (Power Amplifier)
   - LNA (Low Noise Amplifier)
   - Mixer
   - VCO (Voltage-Controlled Oscillator)
   - Custom-made tea-can antenna

2. **Baseband Circuit Implementation**:
   - Waveform generator using a microcontroller(Teensy 4.0) and DAC IC: The programming of Teensy 4.0 is done in the Arduino IDE (integrated development environment)
   - active low pass filter (LPF) with an adjustable gain

3. **Data Acquisition and Processing**:
   - Data collected using Analog Discovery as an oscilloscope.
   - Processed in Python for FFT and other analyses.

### Outcome
This workflow successfully enabled the detection of both stationary and moving targets, demonstrating the functionality of the FMCW radar system.

## Contents

### Lab Reports
- Six lab reports documenting various aspects of the course are included for reference. These are continuously updated:
  - `Lab1_Report.pdf`
  - `Lab2_Report.pdf`
  - `Lab3_Report.pdf`
  - `Lab4_Report.pdf`
  - `Lab5_Report.pdf`
  - `Lab6_Report.pdf`

### Code
- A folder containing reference code used in the project is included: `reference_code/`
  - This folder includes Python scripts and other implementation details used for data processing, component testing, and radar functionality.

