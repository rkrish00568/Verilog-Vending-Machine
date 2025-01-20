# Vending Machine Simulation using Verilog HDL

## Project Description
This project implements a vending machine using Verilog HDL, employing a **Finite State Machine (FSM)** design. The vending machine dispenses three types of products: **Waterbottle**, **Sodabottle**, and **Lemonwater**, based on the inserted amount. It also handles operations such as returning change when excess money is inserted and canceling a transaction.

---

## Features
- **Product Selection**: Supports three products with costs Rs.15, Rs.20, and Rs.25, respectively.
- **Dynamic Coin Count**: Accepts Rs.5 and Rs.10 denominations to meet the cost.
- **Change Return**: Dispenses the exact change if the money inserted exceeds the product cost.
- **Cancel Operation**: Allows users to cancel a transaction, refunding the inserted money.
- **State-based Design**: Implements an FSM with states for product selection, coin insertion, product dispensing, and cancellation.

---

## Project Structure
1. **Verilog Files**:
   - `vending_mach.v`: Contains the main Verilog module implementing the FSM-based vending machine.
   - `vending_mach_tb.v`: Testbench to simulate and verify the functionality of the vending machine.

2. **Simulation Results**:
   - **Waveforms**: Visualize the FSM transitions, product dispensing, and cancel operations.
   - **RTL Netlist**: Synthesize Verilog code into hardware-level logic.

---

## FSM Design
The FSM transitions through the following states:
1. **IDLE**: Awaits product selection.
2. **ITEM0_IN0 / ITEM1_IN1 / ITEM2_IN2**: Checks product availability.
3. **WAITING**: Accepts coins until the total matches or exceeds the product cost.
4. **ST0 / ST1 / ST2 / ST3 / ST4 / ST5**: Updates `coincount` based on Rs.5 or Rs.10 insertion.
5. **WATERBOTTLE / SODABOTTLE / LEMONWATER**: Dispenses the selected product and returns any excess change.
6. **CANCEL**: Refunds the inserted coins if the cancel button is pressed.

---

## Getting Started
### Setup
1. Install **Xilinx Vivado 2018.3** or a compatible Verilog simulation tool.
2. Clone the repository:
   ```bash
   git clone <repository-link>
   cd vending-machine-simulation
