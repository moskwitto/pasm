
section text origin 0x8123
start:
clr cflag
clr dflag
clr iflag
clr vflag
set cflag
set dflag
set iflag
br cflag=0, start
br cflag=1, start
br nflag=0, start
br nflag=1, start
br vflag=0, start
br vflag=1, start
br zflag=0, start

br cflag=0, end
br cflag=1, end
br nflag=0, end
br nflag=1, end
br vflag=0, end
br vflag=1, end
br zflag=0, end
end:

loop: br zflag=1, loop

;Expected:
;w8123
;18 
;d8 
;58 
;b8 
;38 
;f8 
;78 
;90 f7 
;b0 f5 
;10 f3 
;30 f1 
;50 ef 
;70 ed 
;d0 eb 
;90 0c 
;b0 0a 
;10 08 
;30 06 
;50 04 
;70 02 
;d0 00 
;f0 fe 
