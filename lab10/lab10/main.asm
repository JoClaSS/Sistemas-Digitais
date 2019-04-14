;
; lab10.asm
;
; Created: 10/04/2019 16:52:37
; Author : José
;

.include "m328Pdef.inc"
.org 0x000
rjmp main

main: 
 ldi R16, 0xFF
 out DDRB, R16
 out DDRD, R16

loop:			;0b76543210			
 ldi R16,0x18   ;0b00011000
 out portD,R16
 rcall delay
 ldi R16,0x6C
 out portD,R16  ;0b01101100
 sbi portB,0
 rcall delay
 ldi R16,0x98   ;0b10011000
 out portD,R16
 rcall delay
 cbi portB,0
 rjmp loop


 delay:
 clr R16
 clr R17
 ldi R18,100

 delayloop:
  dec R16
  brne delayloop
  dec R17
  brne delayloop
  dec R18
  brne delayloop
  ret
