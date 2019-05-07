;
; lab15.asm
;
; Created: 07/05/2019 10:05:48
; Author : José
;
.include "m328pdef.inc"
.org 0x0000 jmp SETUP

SETUP:
 ldi R16,0xFF
 out DDRB,R16
 out DDRD,R16	
 ldi R16,240
 mov R17,R16

BCD:
 cpi R17,100
 brsh CENTENA
 cpi R17,10
 brsh DEZENA
 cpi R17,10
 brlo UNIDADE
 rjmp WAIT

 WAIT:
  rjmp WAIT

 CENTENA:
  subi R17,100
  inc R20
  cpi R17,100
  brsh CENTENA
  rjmp DISPLAY

 DEZENA:
  subi R17,10
  inc R20
  cpi R17,10
  brsh DEZENA
  rjmp DISPLAY

 UNIDADE:
   mov R20,R17
 
 DISPLAY:  
 cpi R20,0
 breq ZERO
 cpi R20,1
 breq UM 
 cpi R20,2
 breq DOIS
 cpi R20,3
 breq TRES
 cpi R20,4
 breq QUATRO
 cpi R20,5
 breq CINCO
 cpi R20,6
 breq SEIS
 cpi R20,7
 breq SETE
 cpi R20,8
 breq OITO
 cpi R20,9
 breq NOVE
 clr R20
 rjmp BCD


 ZERO:
  ldi R22,0xFC
  out PORTD,R22
  rcall delay
  rjmp BCD

  UM:
  ldi R22,0x0C
  out PORTD,R22
  rcall delay
  rjmp BCD

  DOIS:
  ldi R22,0x6C
  out PORTD,R22
  ldi R22,0x01
  out PORTB,R22
  rcall delay
  rjmp BCD

  TRES:
  ldi R22,0x3C
  out PORTD,R22
  ldi R22,0x01
  out PORTB,R22
  rcall delay
  rjmp BCD

  QUATRO:
  ldi R22,0x92
  out PORTD,R22
  ldi R22,0x01
  out PORTB,R22
  rcall delay
  rjmp BCD
  
  CINCO:
  ldi R22,0xB1
  out PORTD,R22
  ldi R22,0x01
  out PORTB,R22
  rcall delay
  rjmp BCD

  SEIS:
  ldi R22,0xF1
  out PORTD,R22
  ldi R22,0x01
  out PORTB,R22
  rcall delay
  rjmp BCD

  SETE:
  ldi R22,0x1C
  out PORTD,R22
  rcall delay
  rjmp BCD

  OITO:
  ldi R22,0xFC
  out PORTD,R22
  ldi R22,0x01
  out PORTB,R22
  rcall delay
  rjmp BCD

  NOVE:
  ldi R22,0x9C
  out PORTD,R22
  ldi R22,0x01
  out PORTB,R22
  rcall delay
  rjmp BCD

  delay:
   clr R18
   clr R19
   ldi R21,100

  loop:
   dec R18
   brne loop
   dec r19
   brne loop
   dec R21
   brne loop
   ret