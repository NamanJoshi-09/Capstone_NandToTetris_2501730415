# Capstone - Make the Computer Draw a Box
Nand to Tetris - I (ETCCNT301), K.R. Mangalam University
Roll No: 2501730415  |  **K = 15**

| Item | Value |
|---|---|
| K mod 3 = 0 | extra feature: `symbols.txt` (labels + variables with addresses) |
| K mod 4 = 3 | width = 16 x 4 = 64 pixels (4 words per row) |
| Start row | 15 (rows 15-34), height 20 |
| First screen address | 16384 + 32*15 = 16864 |

Files: `CPU.hdl`, `Memory.hdl`, `Computer.hdl`, `assembler.py`, `Box.asm`, `Box.hack`, `symbols.txt`, `tests/` (Add, Max, Rect, Pong .asm/.hack).

Run: `python assembler.py Box.asm` -> `Box.hack` + `symbols.txt`. Load `Box.hack` in the CPU Emulator, run at fast speed, hold any key.
