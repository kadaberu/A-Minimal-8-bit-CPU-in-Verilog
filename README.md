# Simple 8-bit CPU

A minimal 8-bit CPU implemented in Verilog, simulated and visualized on [NVBoard](https://github.com/NJU-ProjectN/nvboard). Built as a learning project to understand how a real processor pipeline fits together — from instruction fetch all the way to seven-segment display output.

> **Note:** Only tested on Linux.

------

## Overview

The CPU executes a hardcoded program out of ROM. It has a 5-bit program counter, four 8-bit general-purpose registers, and four instructions. The demo program computes **1 + 2 + 3 + ... + 10 = 55 (0x37)** and displays the result on a two-digit seven-segment display.

------

## ISA

Four instructions, 8-bit encoding:

| Opcode | Mnemonic           | Operation                             |
| ------ | ------------------ | ------------------------------------- |
| `00`   | `ADD rd, rs1, rs2` | `R[rd] = R[rs1] + R[rs2]`             |
| `10`   | `LI rd, imm`       | `R[rd] = {0000, imm[3:0]}`            |
| `11`   | `BNER0 addr, rs2`  | `if (R[0] != R[rs2]) PC = addr`       |
| `01`   | `DISP rd`          | Display `R[rd]` on seven-segment LEDs |

See `docs/ISA.md` for the full encoding details.

------

## Architecture

- **PC**: 5-bit, supports up to 32 instructions
- **ROM**: combinational `case` block, 9 instructions hardcoded
- **GPR**: 4 × 8-bit registers, updated on clock posedge
- **DISP**: splits `R[rd]` into high/low nibbles, drives two seven-segment digits (`led1`, `led2`)

------

## Demo Program

The ROM encodes a loop that accumulates a triangular sum:

```
LI  R0, 11     ; loop bound (stop when R1 reaches 11)
LI  R1, 1      ; current addend
LI  R2, 0      ; accumulator
LI  R3, 1      ; step = 1
ADD R2, R2, R1 ; acc += addend
ADD R1, R1, R3 ; addend++
BNER0 4, R1    ; if R0 != R1, jump back
DISP R2        ; display result (0x37 = 55)
BNER0 8, R2    ; halt (infinite self-loop)
```

The waveform confirms `R2` reaches `0x37` and both LED outputs stabilize at the corresponding seven-segment encoding.

------

## Project Structure

```
Simple-8bit-CPU/
├── rtl/
│   └── sCPU.v          # Top-level Verilog module
├── sim/
│   ├── sCPU_sim.cpp    # Verilator + NVBoard main loop
│   ├── sCPU_bind.cpp   # Pin bindings (clk, reset, LEDs, debug PC)
│   └── Makefile
├── docs/
│   ├── ISA.md
│   └── architecture.png
└── screenshots/
    └── nvboard.png
```

------

## Dependencies

- [Verilator](https://www.veripool.org/verilator/) — Verilog simulation
- [NVBoard](https://github.com/NJU-ProjectN/nvboard) — virtual FPGA board (seven-segment display, switches, LEDs, buttons)

Make sure NVBoard is installed and its environment variables are set before building. Refer to the NVBoard repo for setup instructions.

------

## Building & Running

First, set `NVBOARD_HOME` in `sim/Makefile` to your local NVBoard installation path:

makefile

```makefile
NVBOARD_HOME = /path/to/nvboard
```

Then build and run:

bash

```bash
cd sim
make sim
```

This invokes Verilator to compile the design, links against NVBoard, and launches the simulation. Once running:

- **BTNC** — clock (one cycle per press)
- **SW0** — reset
- **SEG0 / SEG1** — seven-segment display output
- **LD[4:0]** — debug PC value