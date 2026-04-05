# Synchronous FIFO in Verilog

## Overview
This project implements a synchronous FIFO (First-In-First-Out) buffer using Verilog HDL. The design uses a pointer-based circular buffer and supports asynchronous reset.


## Features
- Parameterized data width and depth
- Pointer-based FIFO (no counter used)
- Full and empty condition detection
- Circular buffer implementation
- Asynchronous reset
- Supports simultaneous read and write
  
## Design Details

- FIFO Type: Synchronous FIFO  
- Reset: Asynchronous  
- Write Pointer (wr_ptr) and Read Pointer (rd_ptr) used  
- Full Condition: (wr_ptr + 1) == rd_ptr, this single thing took time for me to understand, yet its very crucial!
- Empty Condition: wr_ptr == rd_ptr



## Key Learnings

- Understanding FIFO using circular buffer
- Why only (depth - 1) elements are stored
- Avoiding modulo (%) using pointer wrap-around
- Handling simultaneous read/write conditions
- Debugging timing issues (missing last data)
- Understanding RTL to hardware mapping



## Files

- fifo.v → FIFO design  
- fifo_tb.v → Testbench  
- Waveform.png → Simulation waveform  
- Schematic_Diagram.png → RTL schematic  



## Simulation Result

The waveform confirms:
- Correct FIFO order (First-In-First-Out)
- Proper full and empty behavior
- Correct handling of simultaneous read/write
