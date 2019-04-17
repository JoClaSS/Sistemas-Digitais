.include "m328pdef.inc"
.org 0x0000
rjmp main
main:
   sbi DDRB,5
   ldi R16, 0b00000101
   out TCCR0B, R16        ;prescale clk/1024
   ldi R16, 0b00000010		
   out TCCR0A, R16        ;CTC
   ldi R16, 0b11111111
   out OCR0A, R16
   clr R16

press:
    cpi R16,0x04
	breq RESULTADO
    in R20,PINB
  andi R20,0x01			 ;mask to 0b0000001 
   cpi R20,0x01 
  breq ON_RED
    in R20,PINB
  andi R20,0x02
   cpi R20,0x02
  breq ON_GREEN
    in R20,PINB
  andi R20,0x04
   cpi R20,0x04
  breq ON_BLUE
  rjmp press

ON_RED:
 sbi portB,5
 rcall delay
 cbi portB,5
 rcall delay
  inc R16
  mov R21,R16
 andi R21,0x01
  cpi R21,0x01
 breq CORRETO
 andi R21,0x03
  cpi R21,0x03
 breq CORRETO
 rjmp press

ON_GREEN:
 sbi portB,5
 rcall delay
 cbi portB,5
 rcall delay
  inc R16
  mov R21,R16
 andi R21,0x02
  cpi R21,0x02
 breq CORRETO
 rjmp press

ON_BLUE:
 inc R16
 sbi portB,5
 rcall delay
 cbi portB,5
 rcall delay
 inc R16
 mov R21,R16
 andi R21,0x04
 cpi R21,0x04
 breq CORRETO
 rjmp press

delay:
 clr R18
 clr R19
 ldi R17,100
delay_loop:
 dec R19
 brne delay_loop
 dec R18
 brne delay_loop
 dec R17
 brne delay_loop
 ret 

 CORRETO:
  inc R22
  rjmp press

 RESULTADO:
  cpi R22,0x04
  breq ABRIR
 FAIL:
  clr R16
  clr R22
 rjmp press

ABRIR:
 sbi portB,5
 rjmp press
