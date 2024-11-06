
; Pécs Assembler 23 example program
;
; The semicolon starts a comment that lasts until the end of line.

VIA_BASE = 0x8000  ; Variables can be defined that way: name, equal sign, expression.
VIA_PORTB = VIA_BASE
VIA_DDRB = VIA_BASE + 2  ; The expression can contain numbers, variables and operations like plus or times.
                         ; Numbers can be input in decimal (1234), hexadecimal (0x4002), or binary (0b10010101) format.

section text origin 0x4000     ; The section directive tell the compiler, where to put the machine code or data that comes next.
                               ; Traditionally the section where your code goes is called "text"

start:                         ; Another way to define variables is by a label: it is a name followed by a colon.
       mov a, [var1]           ; var1 is a variable that is defined later, in the data segment
       mov [VIA_DDRB],  a      ; Set all pins of PORTB to output.
loop:  mov [VIA_PORTB], a      ; The label can be on the same line as the instruction (before it).
       inc a
       jmp loop                ; Create an infinite loop.

section data  origin 0x4100
var1:  db  0xff                ; We just put 0xff into address 0x8100, to be read in at the start.

section vectors origin 0xfffc  ; The section for the reset vectors.
       dw  start               ; The assebler will automatically calculate the address of the start of the program.
                               ; An alternative would be to do it by hand:
                               ;    dw  0x8000   ; in this case the assembler takes care of the word order
                               ; or we can just control every byte:
                               ;    db  00, 80
