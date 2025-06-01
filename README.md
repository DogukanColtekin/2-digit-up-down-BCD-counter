# 2-Digit Up/Down BCD Counter on FPGA

This project implements a 2-digit, parallel-loadable up/down BCD counter using VHDL and targets the Xilinx Spartan VI FPGA on the Nexys3 board. The design allows counting via push-button presses, displaying results on a two-digit 7-segment LED display.

## Project Details

- **VHDL Standard**: VHDL-93
- **Target FPGA**: Xilinx Spartan-6 (XC6LX16-CS324) on the Nexys3 board

## Overview

The counter:
- Supports parallel loading of an 8-bit BCD value using 8 slide switches.
- Counts up or down by pressing and releasing dedicated push-button switches (BTNU and BTND).
- Displays the current count on the two least significant digits of the Nexys3’s 7-segment LED display.

## Features

**Parallel Loading** — Loads 8-bit BCD data using slide switches (SW0-SW7) and BTNL button.  
**Up Counting** — Increments the counter by one on each press/release of BTNU.  
**Down Counting** — Decrements the counter by one on each press/release of BTND.  
**Debouncing** — Uses a shift register and AND gate approach to filter switch bounce.  
**BCD to 7-Segment Display** — Displays the count on a dual 7-segment LED display.

## Components

- **VHDL modules**:
  - Frequency Divider (clock divider from 100 MHz to ~100 Hz)
  - Switch Debouncer
  - 2-digit Up/Down BCD Counter with Parallel Load
  - BCD to 7-segment decoder
- **Testbenches** for individual modules (using ISim)
- **.ucf file** for pin assignments

## Hardware

- **FPGA Board**: Nexys3 (Xilinx Spartan VI)
- **Inputs**:
  - Slide Switches (SW0-SW7) for parallel load data
  - BTNL (pload), BTNU (upcount), BTND (downcount)
- **Outputs**:
  - SSEG_CA (7 downto 0)
  - SSEG_AN (3 downto 0)

## Usage

1. **Setup**: Load the project in Xilinx ISE and assign pins using the provided `.ucf` file or manually according to the board connections.
2. **Synthesize and Implement**: Use ISE to synthesize, implement, and generate the bitstream file.
3. **Upload**: Upload the bitstream to the Nexys3 FPGA board.
4. **Test**:
   - Use slide switches to set the initial count (in BCD).
   - Press BTNL to load.
   - Press and release BTNU to count up, or BTND to count down.
   - Observe the count on the two-digit 7-segment display.
