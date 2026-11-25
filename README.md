# Capstone: Make the Computer Draw a Box

**Course:** Nand to Tetris – I (ETCCNT301), School of Engineering & Technology, K.R. Mangalam University  
**Roll No.:** 2501730415 &nbsp;|&nbsp; **K:** 15

## Overview

This project builds a working Hack computer, a two-pass assembler in Python, and an assembly program (`Box.asm`) that draws a black box on the screen while any key is pressed and clears it when the key is released.

The work is divided into three main parts:

1. **Hardware (`CPU.hdl`, `Memory.hdl`, `Computer.hdl`)** – Implements the Hack CPU, combined RAM/Screen/Keyboard memory map, and full computer system.
2. **Assembler (`assembler.py`)** – Translates Hack assembly instructions (`.asm`) into 16-bit binary machine code (`.hack`) and exports symbol mappings.
3. **Box Program (`Box.asm`)** – Polls the keyboard in a loop and fills a `K`-derived rectangle on the screen when a key is held down.

## Parameters for Roll No. 2501730415 (K = 15)

| Parameter | Calculation / Detail | Value |
|---|---|---|
| Box start row | `K` | Row 15 |
| Box height | Fixed 20 rows | Rows 15–34 |
| Box width | `16 × ((15 mod 4) + 1)` | 64 pixels (4 words per row) |
| First screen word address | `16384 + 32 × 15` | 16864 |
| Assembler extra feature | `15 mod 3 = 0` | Writes labels and variables with addresses to `symbols.txt` |

## Repository Structure

| Path | Purpose |
|---|---|
| `CPU.hdl` | Instruction decoding, A/D registers, ALU control, `writeM`, and jump logic |
| `Memory.hdl` | Address routing across RAM (`0–16383`), Screen (`16384–24575`), and Keyboard (`24576`) |
| `Computer.hdl` | Integrates `ROM32K`, `CPU`, and `Memory` into the Hack computer |
| `assembler.py` | Two-pass Python assembler producing `.hack` and `symbols.txt` |
| `Box.asm` | Assembly source for the interactive box program |
| `Box.hack` | Binary machine code generated from `Box.asm` |
| `symbols.txt` | Output file listing labels, variables, and their assigned addresses |
| `tests/` | Test assembly programs and reference outputs (`Add`, `Max`, `Rect`, `Pong` `.asm`/`.hack`) |

## How `assembler.py` Works

* **Pass 1:** Strips comments and empty lines while recording label declarations such as `(LOOP)` with the ROM address of the following instruction.
* **Pass 2:** Encodes A-instructions as 16-bit unsigned binary addresses (assigning user variables starting at RAM address `16`) and C-instructions as `111` + `comp` + `dest` + `jump`.
* **Symbol Export:** Because `K mod 3 = 0`, writes every label and variable alongside its address into `symbols.txt`.

## How `Box.asm` Works

`Box.asm` runs an infinite loop that checks memory address `24576` (the keyboard register). When a key code is non-zero, `color` is set to `-1` (`1111111111111111` in two's complement, black); otherwise `color` is set to `0` (white). Starting at screen address `16864`, it writes `color` into 4 consecutive words per row across 20 rows, advancing down one screen row per iteration by adding `32` to the row pointer.

## Usage & Testing

Assemble `Box.asm` (or any test `.asm` file in `tests/`):

```bash
python assembler.py Box.asm
```

This generates `Box.hack` and `symbols.txt`.

To run and verify the project:

* **Hardware tests:** Run `CPU.tst`, `Memory.tst`, `ComputerAdd.tst`, `ComputerMax.tst`, and `ComputerRect.tst` in the Nand to Tetris Hardware Simulator.
* **Assembler verification:** Compare `assembler.py` outputs against the reference assembler on `Add.asm`, `Max.asm`, `Rect.asm`, and `Pong.asm`.
* **Interactive box check:** Open the **CPU Emulator**, load `Box.hack`, set animation speed to fast, enable the keyboard, and press and hold any key to see the box appear and disappear.