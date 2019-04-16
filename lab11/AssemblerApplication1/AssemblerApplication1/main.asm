;
; AssemblerApplication1.asm
;
; Created: 14/04/2019 22:15:37
; Author : José
;


.include "m328Pdef.inc"
.org 0x000
rjmp main


main: 
  sbi DDRB,5


loop:
  clr R16
  out DDRD,R16  
  in R17,PIND   ;0b10000000
  cpi R17, 0x80 ;porta 3
  breq ON
  rjmp loop      


ON:
 sbi PORTB,5
 rjmp loop
