;
; lab12.asm
;
; Created: 23/04/2019 00:25:28
; Author : José
;
.INCLUDE "m328Pdef.inc"
.org 0x0000 jmp SETUP
.org 0x002A jmp BARRA

  SETUP:
  ldi R16,0x0F ; 0000 1111
  out DDRB,R16 
  ldi R16,0b01100000
  sts ADMUX,R16
  ldi R16,0b11001101 
  sts ADCSRA,R16
  ldi R16,0x80 
  out SREG,R16
   
 WAIT:
   rjmp WAIT

  BARRA:
  lds R18,ADCH
  cpi R18,63
  brlo ONLED1
   cpi R18,126
  brlo ONLED12
   cpi R18,200
  brlo ONLED123
   cpi R18,200
  brsh ONLED1234
  reti 
  
  ONLED1:
   ldi R19,0x01  ;0000 0001
   out PORTB,R19
   ldi R16,0b11001101 
   sts ADCSRA,R16
   ldi R16,0x80 
   out SREG,R16
   reti

  ONLED12:
   ldi R19,0x03  ;0000 0011
   out PORTB,R19
   ldi R16,0b11001101 
   sts ADCSRA,R16
   ldi R16,0x80 
   out SREG,R16
   reti

   ONLED123:
   ldi R19,0x07  ;0000 0111
   out PORTB,R19
   ldi R16,0b11001101 
   sts ADCSRA,R16
   ldi R16,0x80 
   out SREG,R16
   reti

   ONLED1234:
   ldi R19,0x0F  ;0000 1111
   out PORTB,R19
   ldi R16,0b11001101 
   sts ADCSRA,R16
   ldi R16,0x80 
   out SREG,R16
   reti
     

 
    