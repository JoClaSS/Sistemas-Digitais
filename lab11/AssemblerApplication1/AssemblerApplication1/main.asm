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

press:
    in R16,PINB
  andi R16,0x01 ;mask to 0b0000001 
   cpi R16,0x01 
  breq ON_RED
  andi R16,0x02
   cpi R16,0x02
  breq ON_GREEN
  andi R16,0x04
   cpi R16,0x04
  breq ON_BLUE
  rjmp press

ON_RED:
 sbi portB,5
 rcall delay
 cbi portB,5
 rjmp press

ON_GREEN:
 sbi portB,5
 rcall delay
 cbi portB,5
 rjmp press

ON_BLUE:
 sbi portB,5
 rcall delay
 cbi portB,5
 rjmp press
