.include "m328pdef.inc"
.org 0x0000 
rjmp MAIN
 
 MAIN: 
 ldi R16,0x1C               ;0b 0001 1100
 out DDRD,R16
 ldi R16, 0b00000101        ;clk/1024 
 out TCCR0B, R16
 ldi R16, 0b00000010		;CTC
 out TCCR0A, R16
 ldi R16, 0xFF
 out OCR0A, R16
 ldi R16,0x02
 sts TIMSK0,R16
 ldi R16,0x1C
 out PORTD,R16
 clr R16
 clr R20
 clr R21
 out TCNT0,R16


 WAIT:
    in R16,PINB
  andi R16,0x04
   cpi R16,0x04
  brne WAIT
   out PORTD,R20
   clr R16
 rcall DELAY

 PRESS:
    cpi R20,0x04
   breq RESULTADO
     in R16,PINB    ; 0000 0100
   andi R16,0x04
    cpi R16,0x04
   breq RED
     in R17,PINB     ;0000 0010
   andi R17,0x02
    cpi R17,0x02
   breq GREEN 
     in R18,PINB     ;0000 0001
   andi R18,0x01
    cpi R18,0x01
   breq BLUE
   rjmp PRESS

  RED:
     sbi PORTD,2
   rcall delay
     cbi PORTD,2
   rcall delay
     inc R20
     cpi R20,0x01
    breq CORRETO
     cpi R20,0x03
    breq CORRETO
    rjmp press

  GREEN:
   sbi PORTD,3
   rcall DELAY
   cbi PORTD,3
   rcall DELAY
   inc R20
   cpi R20,0x02
   breq CORRETO
   rjmp PRESS

   BLUE:
   sbi PORTD,4
   rcall DELAY
   cbi PORTD,4
   rcall DELAY
   inc R20
   cpi R20,0x04
   breq CORRETO
   rjmp PRESS

   CORRETO:
    inc R21
	rjmp PRESS

	RESULTADO:
	 cpi R21,0x04
	 breq ABRIR
	FAIL:
	 sbi PORTD,2
	 rcall DELAY
	 cbi PORTD,2
	 sbi PORTD,3
	 rcall DELAY
	 cbi PORTD,3
	 sbi PORTD,4
	 rcall DELAY
	 cbi PORTD,4
	 rjmp MAIN

	ABRIR:
	  ldi R21,0xFF
	  out PORTD,R21
	LOOP:
	 RJMP LOOP

	 DELAY:
	 ldi R24, 100
	 clr R22
	 clr R23

	 DELAYLOOP:
	 dec R22
	 brne DELAYLOOP
	 dec R23
	 brne DELAYLOOP
     dec R24
	 brne DELAYLOOP
	 ret
	 
	  
