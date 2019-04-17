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
 cbi portB,2
 ldi R16,0x18   ;0b01101100
 out portD,R16
 ldi R16, 0b
 out portB,4
 rcall delay
 cbi portB,4
 ldi R16,0xFC
 out portD,R16  ;0b11111100
 ldi R16,0x09   ;0b00001001
 out portB,R16
 rcall delay
 cbi portB,3
 ldi R16,0x98   ;0b10011000
 out portD,R16
 sbi portB,2
 rcall delay
 cbi portB,0
 rjmp loop


 delay:
 clr R16
 clr R17
 ldi R18,1

 delayloop:
  dec R16
  brne delayloop
  ret
