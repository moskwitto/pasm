
; Pécs Assembler 23 example program
;
; The semicolon starts a comment that lasts until the end of line.

VIA_BASE = 0x8000  ; Variables can be defined that way: name, equal sign, expression.
VIA_PORTB = VIA_BASE
VIA_PORTA = VIA_BASE + 1
VIA_DDRB = VIA_BASE + 2  ; The expression can contain numbers, variables and operations like plus or times.
VIA_DDRA = VIA_BASE + 3

                         ; Numbers can be input in decimal (1234), hexadecimal (0x4002), or binary (0b10010101) format.


;Finding these numbers and inserting here is the job f the linker:

lcdlib_end = 0x4033
print_string = 0x4026
lcd_command = 0x4013
print_char = 0x4000



section text origin 0x4100     ; The section directive tell the compiler, where to put the machine code or data that comes next.
                               ; Traditionally the section where your code goes is called "text"

start:                         ; Another way to define variables is by a label: it is a name followed by a colon.


       set cflag
       mov a, [var2] ; least significant byte of var2
       subc a, [var3] ;
       mov [result1], a    ; save the result
       mov a, [var2+1]      ; most significant byte of var2
       subc a, [var3+1]   ;   a = a + 35 + carry
       mov [result1+1], a    ;  W 00

       mov a, 4
       set cflag
       rol a        ;  00000100   rotate left
       mov [7], a   ;  00001001 = 9

       mov a, 4
       set cflag
       ror a        ;  00000100   rotate right
       mov [7], a   ;  10000010 = 128+2




      ; jmp loop              ; finish here

       mov a, 0xff           ; var1 is a variable that is defined later, in the data segment
       mov [VIA_DDRB],  a      ; Set all pins of PORTB to output.
       mov a, 0b11100000
       mov [VIA_DDRA],  a      ; Set PA5, PA6, PA7 pins of PORTA to output.


       mov a, 0b00111000
       call lcd_command
       mov a, 0b00001111
       call lcd_command

       ; we should decide if bit 3 of result1 is 0 or 1
       mov a, [result1]
       and a, 0b00000100
       br zflag=1, somewhere  ; if bit 3 was 0 then jump somewhere
       mov a, 49  ;           ; otherwise continue here  65 = A
       call print_char
       jmp loop

       ; How to print a number(byte or two bytes) in binary to the LCD
somewhere:
       mov a, 48  ;  49 = ASCII 0
       call print_char
       










loop:
       jmp loop                ; Create an infinite loop.


      ; prints a character to the already initialized LCD
      ; input is in a


section data  origin 0x4200
var1:  db  0xff                ; We just put 0xff into address 0x8100, to be read in at the start.


var2:  dw  300  ; larger than 255, it consumes 2 bytes  var2 = 4101
var3:  dw  400       ;                                  var3 = 4103
result1:  dw 0    ;                                   result1 = 4105
somestring:   db   65,66,67,68,0   ;  ABCD in ascii, then a zero marking the end of the string


section vectors origin 0xfffc  ; The section for the reset vectors.
       dw  start               ; The assebler will automatically calculate the address of the start of the program.
                               ; An alternative would be to do it by hand:
                               ;    dw  0x8000   ; in this case the assembler takes care of the word order
                               ; or we can just control every byte:
