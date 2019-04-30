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
  ldi R16,0x1E ; 0001 1110
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

  lds R16,ADCH
  lds R17,ADCL

  THRESHOLDS:
  cpi R17,50
  brlo ONLED1
  cpi R17,100
  brlo ONLED12
  cpi R17,150
  brlo ONLED123
  cpi R17,230
  brlo ONLED1234
  rjmp READ
  
  ONLED1:
   ldi R18,0x02  ;0000 0010
   out PORTB,R18
  rjmp READ

  ONLED12:
   ldi R18,0x06  ;0000 0110
   out PORTB,R18
  rjmp READ

   ONLED123:
   ldi R18,0x0E  ;0000 1110
   out PORTB,R18
  rjmp READ

   ONLED1234:
   ldi R18,0x1E  ;0000 0110
   out PORTB,R18
  rjmp READ
     

 
    