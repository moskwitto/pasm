
; Pécs Assembler 23 example program
;
; The semicolon starts a comment that lasts until the end of line.

VIA_BASE = 0x8000  ; Variables can be defined that way: name, equal sign, expression.
VIA_PORTB = VIA_BASE
VIA_PORTA = VIA_BASE + 1
VIA_DDRB = VIA_BASE + 2  ; The expression can contain numbers, variables and operations like plus or times.
VIA_DDRA = VIA_BASE + 3

                         ; Numbers can be input in decimal (1234), hexadecimal (0x4002), or binary (0b10010101) format.



section text origin 0x4000     ; The section directive tell the compiler, where to put the machine code or data that comes next.
                               ; Traditionally the section where your code goes is called "text"

start:                         ; Another way to define variables is by a label: it is a name followed by a colon.
       mov a, 0xff           ; var1 is a variable that is defined later, in the data segment
       mov [VIA_DDRB],  a      ; Set all pins of PORTB to output.
       mov a, 0b11100000
       mov [VIA_DDRA],  a      ; Set PA5, PA6, PA7 pins of PORTA to output.


       mov a, 0
       mov [VIA_PORTA], a      ; set RW, E, RS = 0
       mov a, 0b00111000
       mov [VIA_PORTB], a      ; 

       mov a, 0b01000000
       mov [VIA_PORTA], a      ; set E=1
       mov a, 0b00000000
       mov [VIA_PORTA], a      ; set E=0




       mov a, 0
       mov [VIA_PORTA], a      ; set RW, E, RS = 0
       mov a, 0b00001111
       mov [VIA_PORTB], a      ; display on, cursor off

       mov a, 0b01000000
       mov [VIA_PORTA], a      ; set E=1
       mov a, 0b00000000
       mov [VIA_PORTA], a      ; set E=1



       mov a, 0b01001010   ; put the input char into a
       call print_char     ; call the function

       mov a, 0b01001011   ; put the input char into a
       call print_char     ; call the function

       mov a, 0b01001100   ; put the input char into a
       call print_char     ; call the function
       
loop:
       jmp loop                ; Create an infinite loop.

       ;This function prints a character to the already initialized LCD
       ; input is in a (ASCII code of the character, or some japaneses)
print_char:
       mov [VIA_PORTB], a      ; Your favourite letter
       mov a, 0b00100000
       mov [VIA_PORTA], a      ; set RS = 1, RW = E =0
       mov a, 0b01100000
       mov [VIA_PORTA], a      ; set RS = 1, RW = 0, E=1
       mov a, 0b00100000
       mov [VIA_PORTA], a      ; set RS = 1, RW = E =0
       ret

section data  origin 0x4100
var1:  db  0xff                ; We just put 0xff into address 0x8100, to be read in at the start.

section vectors origin 0xfffc  ; The section for the reset vectors.
       dw  start               ; The assebler will automatically calculate the address of the start of the program.
                               ; An alternative would be to do it by hand:
                               ;    dw  0x8000   ; in this case the assembler takes care of the word order
                               ; or we can just control every byte:
                               ;    db  00, 80