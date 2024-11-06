
; Pécs Assembler 23 example program
;
; The semicolon starts a comment that lasts until the end of line.

VIA_BASE = 0x4000  ; Variables can be defined that way: name, equal sign, expression.
VIA_PORTB = VIA_BASE
VIA_DDRB = VIA_BASE + 2  ; The expression can contain numbers, variables and operations like plus or times.
                         ; Numbers can be input in decimal (1234), hexadecimal (0x4002), or binary (0b10010101) format.

section text origin 0x8000     ; The section directive tell the compiler, where to put the machine code or data that comes next.
                               ; Traditionally the section where your code goes is called "text"

start:
       mov a, [var1]
       mov [VIA_DDRB],  a      ; Set all pins of PORTB to output.
again: mov x, epat - patt        ; epat-patt is the number of bytes in the pattern
loop:  mov a, [ patt + x ]
       mov [VIA_PORTB], a      ; The label can be on the same line as the instruction (before it).
       dec x
       br  zflag=0, loop       ; x is not yet zero, we continue with the next byte in the pattern
                               ; (You might spot a bug here!)
       jmp again               ; x reached zero, we start again in an infinite loop.

section data  origin 0x8100
var1:  db  0xff                ; We just put 0xff into address 0x8100, to be read in at the start.
patt:  db  0b00000001          ; Moving light pattern
       db  0b00000010
       db  0b00000100
       db  0b00001000
       db  0b00010000
       db  0b00100000
       db  0b01000000
       db  0b10000000
epat:
var3:  db  0xff

section vectors origin 0xfffc  ; The section for the reset vectors.
       dw  start      ; The assebler will automatically calculate the address of the start of the program.
                               ; An alternative would be to do it by hand:
                               ;    dw  0x8000   ; in this case the assembler takes care of the word order
                               ; or we can just control every byte:
                               ;    db  00, 80


;Expected:
;Symbol table
;VIA_DDRB = 16386 (0x4002)
;VIA_PORTB = 16384 (0x4000)
;VIA_BASE = 16384 (0x4000)
;var3 = 33033 (0x8109)
;epat = 33033 (0x8109)
;patt = 33025 (0x8101)
;var1 = 33024 (0x8100)
;loop = 32776 (0x8008)
;again = 32774 (0x8006)
;start = 32768 (0x8000)
;
;w8000
;ad 00 81 
;8d 02 40 
;a2 08 
;bd 01 81 
;8d 00 40 
;ca 
;d0 f7 
;4c 06 80 
;w8100
;ff 
;01 
;02 
;04 
;08 
;10 
;20 
;40 
;80 
;ff 
;wfffc
;00 80 

