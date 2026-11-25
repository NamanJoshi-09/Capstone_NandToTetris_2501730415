// Box.asm   Roll No 2501730415   K = 15
// Box: starts at row K = 15, 20 rows tall, 64 pixels wide (4 words),
//      attached to the left edge of the screen.
//   width  = 16 * ((15 mod 4) + 1) = 16 * 4 = 64 pixels = 4 words
//   first word address = SCREEN + 32*15 = 16384 + 480 = 16864
// Box is black while any key is pressed, white (erased) when released.

(LOOP)
    @KBD
    D=M
    @PRESSED
    D;JNE           // key pressed -> use black
    @colour
    M=0             // no key -> white (erase)
    @PAINT
    0;JMP
(PRESSED)
    @colour
    M=-1            // all 16 bits = 1 -> black

(PAINT)
    @16864
    D=A
    @addr
    M=D             // addr = first word of row 15
    @20
    D=A
    @rows
    M=D             // 20 rows to paint

(ROW)
    @colour
    D=M
    @addr
    A=M
    M=D             // word 0 (pixels 0-15)
    A=A+1
    M=D             // word 1 (16-31)
    A=A+1
    M=D             // word 2 (32-47)
    A=A+1
    M=D             // word 3 (48-63)

    @32
    D=A
    @addr
    M=D+M           // addr += 32 -> start of next row

    @rows
    M=M-1
    D=M
    @ROW
    D;JGT           // more rows left?

    @LOOP
    0;JMP           // check keyboard again
