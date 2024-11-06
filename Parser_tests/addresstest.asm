section text origin 0x8000
  mov a, 0x42
  mov a, [ 0x8142 ]
  mov a, [ 0x8142 + x ]
  mov a, [ 0x8142 + y ]
  mov a, zp[ 0x43 ]
  mov a, zp[ 0x43 + x ]
  mov x, zp[ 0x43 + y ]
  mov a, [zp[ 0x43 ]]
  mov a, [zp[ 0x43 + x ]]
  mov a, [zp[ 0x43 ] + y ]
  jmp [ 0x8144 ]
  jmp [ 0x8144 + x ]
text_end:

;Expected:
;w8000
;a9 42 
;ad 42 81 
;bd 42 81 
;b9 42 81 
;a5 43 
;b5 43 
;b6 43 
;b2 43 
;a1 43 
;b1 43 
;6c 44 81 
;7c 44 81 



