
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



      ; prints a character to the already initialized LCD
      ; input is in a
print_char:
       mov [VIA_PORTB], a      ; Your favourite letter
       mov a, 0b00100000
       mov [VIA_PORTA], a      ; set RS = 1 RW=E=0
       mov a, 0b10100000
       mov [VIA_PORTA], a      ; set E=1
       mov a, 0b00100000
       mov [VIA_PORTA], a      ; set E=0
       ret

    ; send a command to the LCD
    ; input is in a
lcd_command:
       mov [VIA_PORTB], a      ;.
       mov a, 0
       mov [VIA_PORTA], a      ; set RW, E, RS = 0

       mov a, 0b10000000
       mov [VIA_PORTA], a      ; set E=1
       mov a, 0b00000000
       mov [VIA_PORTA], a      ; set E=0
       ret

     ; print a null terminated string to the lcd
     ; the input pointer is at [0] and [1]
     ; the function uses a, y
print_string:
     mov y, 0
     mov a, [zp[0] + y ]
     cmp a, 0
     br zflag=1, exit_print_string
     call print_char
     inc y
exit_print_string:
     ret

lcdlib_end:

