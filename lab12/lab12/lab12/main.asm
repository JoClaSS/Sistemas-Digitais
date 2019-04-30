;
; lab12.asm
;
; Created: 23/04/2019 00:25:28
; Author : José
;

.INCLUDE "m328Pdef.inc"
.org 0x0000
rjmp MAIN

MAIN:
  ldi R16,0x00
  out DDRC,R16
  ldi R16,0x0F ; 0001 1110
  out DDRB,R16 
  ldi R16,0b011000000
  sts ADMUX,R16
  
 
  READ:
  ldi R16,0b11000111
  sts ADCSRA,R16

  WAIT:
  lds R15,ADCSRA
  sbrs R15,4
  rjmp WAIT

  lds R18,ADCH
  lds R17,ADCL

  THRESHOLDS:
  cpi R17,50
  brlo ONLED1
  cpi R17,100
  breq ONLED12
  cpi R17,150
  breq ONLED123
  cpi R17,230
  breq ONLED1234
  rjmp READ
  
  ONLED1:
   ldi R19,0x01  ;0000 0010
   out PORTB,R19
  rjmp READ

  ONLED12:
   ldi R19,0x03  ;0000 0110
   out PORTB,R19
  rjmp READ

   ONLED123:
   ldi R19,0x07  ;0000 1110
   out PORTB,R19
  rjmp READ

   ONLED1234:
   ldi R19,0x0F  ;0001 1110
   out PORTB,R19
  rjmp READ
     

 
    