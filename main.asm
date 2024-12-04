
; Pécs Assembler 23 example program
;
; The semicolon starts a comment that lasts until the end of line.

VIA_BASE = 0x8000  ; Variables can be defined that way: name, equal sign, expression.
VIA_PORTB = VIA_BASE
VIA_PORTA = VIA_BASE + 1
VIA_DDRB = VIA_BASE + 2  ; The expression can contain numbers, variables and operations like plus or times.
VIA_DDRA = VIA_BASE + 3

                         ; Numbers can be input in decimal (1234), hexadecimal (0x4002), or binary (0b10010101) format.


;Finding these numbers is normally the linker's job:
lcdlib_end = 0x4033
print_string = 0x4026
lcd_command = 0x4013
print_char = 0x4000


section text origin 0x4100     ; The section directive tell the compiler, where to put the machine code or data that comes next.
                               ; Traditionally the section where your code goes is called "text"

start:                         ; Another way to define variables is by a label: it is a name followed by a colon.






      ;setting up the LCD

       mov a, 0xff           ; var1 is a variable that is defined later, in the data segment
       mov [VIA_DDRB],  a      ; Set all pins of PORTB to output.
       mov a, 0b11100000
       mov [VIA_DDRA],  a      ; Set PA5, PA6, PA7 pins of PORTA to output.


       mov a, 0b00111000
       call lcd_command
       mov a, 0b00001111
       call lcd_command
       mov a, 0b00000001  ; clear screen
       call lcd_command

       ; wait for some time

       mov y, 10
outer_loop:
       mov x, 255
inner_loop:
       dec x
       br zflag=0, inner_loop
       dec y
       br zflag=0, outer_loop

       clr iflag  ; enable interrupts
main_loop:
       ; reading PA0

       mov a, [therewasaninterrupt]
       cmp a, 0
       br zflag=1, main_loop

       mov a, irqvar
       and a, 0b00000001  ; get rid of garbage

       br zflag=1, go0
       mov a, 49  ; ascii 1
       call print_char
       jmp loop

go0:
       mov a, 48  ; ascii 0
       call print_char
       jmp loop

       ; testing print_x

       mov a, 15
       call print_X

       mov a, 0b01001010
       call print_X     ; expect 4A on the LCD
     

loop:
       jmp loop                ; Create an infinite loop.


       ;Prints a number in hexadecimal to the LCD
       ; input is in a
print_X:
      ; write the function here
      ; compare a to 10
      ; continue here if not smaller
      ;  a = a + 55
      ; call print char
      ; return

      ; jump here if smaller
      ;  a = a + 48
      ; call print char
      ; return


      ret

irq_handler:
      push a
      mov a, [VIA_PORTA]
      mov [irqvar], a
      mov a, 1
      mov [therewasaninterrupt], a
      pull a
      iret



section data  origin 0x4200
var1:  db  0xff                ; We just put 0xff into address 0x8100, to be read in at the start.
irqvar:  db  0
therewasaninterrupt  db  0

var2:  dw  300  ; larger than 255, it consumes 2 bytes  var2 = 4101
var3:  dw  400       ;                                  var3 = 4103
result1:  dw 0    ;                                   result1 = 4105
somestring:   db   65,66,67,68,0   ;  ABCD in ascii, then a zero marking the end of the string


section vectors origin 0xfffc  ; The section for the reset vectors.
       dw  start               ; The assebler will automatically calculate the address of the start of the program.
       dw  irq_handler         ; An alternative would be to do it by hand:
                               ;    dw  0x8000   ; in this case the assembler takes care of the word order
                               ; or we can just control every byte:
