;
; prova.asm
;
; Created: 07/05/2019 15:05:50
; Author : José
;
.org 0x0000 jmp INIT
.include "m328pdef.inc"

INIT:
  ldi R16,0x0F
  out DDRB,R16
  ldi R16,0xFC
  out DDRD,R16
  	
COIN_STORE:
  ldi R18,0x00 ; 1C
  PUSH R18
  ldi R18,0x00 ; 5C
  PUSH R18
  ldi R18,0x00 ; 10C
  PUSH R18
  ldi R18,0x00 ; 25C
  PUSH R18
  ldi R18,0x00 ; 50C
  PUSH R18
  ldi R18,0x00 ;1R
  PUSH R18
  ldi R16,212 ; RL  - - - - - - - -
 ;ldi R17,0x00 ; RH  x x x x x x - -

  /* POP R23 ; 1
   POP R22 ; 0.5
   POP R21 ;0,25
   POP R20 ;0.1
   POP R19 ;0.05
   POP R18 ;0.01
   */
 MOEDA:
  cpi R16,100
  brsh UMREAL
  cpi R16,50
  brsh CINQUENT
  cpi R16,25
  brsh VINTEC
  cpi R16,10
  brsh DEZC
  cpi R16,5
  brsh CINC
  cpi R16,1
  brsh UMC
  PUSH R18 ;0.01
  PUSH R19 
  PUSH R26 
  PUSH R21 
  PUSH R22 
  PUSH R23 ;1
  rjmp UPDW

  UMREAL: 
  inc R23
  subi R16,100
  rjmp MOEDA

  CINQUENT: 
  inc R22
  subi R16,50
  rjmp MOEDA

  VINTEC: 
  inc R21
  subi R16,25
  rjmp MOEDA

  DEZC: 
  inc R26
  subi R16,10
  rjmp MOEDA

  CINC: 
  inc R19
  subi R16,5
  rjmp MOEDA
 
  UMC: 
  inc R18
  subi R16,1
  rjmp MOEDA

  UPDW:           ;botão
   in R28,PINC
   andi R28,0x01
   cpi R28,0x01 ;A0
   breq UP
   in R28,PINC
   cpi R28,0x02
   andi R28,0x02 ;A1
   breq DW
   rjmp UPDW
  
  UP:      ;; botão intervalo
   inc R25
  rjmp CN
  DW:
   dec R25
  rjmp CN

  CN:
   cpi R25,0
   breq C0
   cpi R25,1
   breq C1
   cpi R25,2
   breq C2
   cpi R25,3
   breq C3
   cpi R25,4
   breq C4
   cpi R25,5
   breq C5 
  rjmp UPDW
   
   C0: 
    ldi R20,0
	rcall BCD
	out PORTD,R20
	ori R20,0x02
	out PORTB,R20
	rcall delay
	ldi R20,0
	rcall BCD
	out PORTD,R20
	ori R20,0x04
	out PORTB,R20
	rcall delay
	mov R20,R18
	rcall BCD
	out PORTD,R16
	ori R17,0x08
	out PORTB,R17
	rcall delay
	rjmp UPDW

	C1: 
    ldi R20,1
	rcall BCD
	out PORTD,R20
	ori R20,0x02
	out PORTB,R20
	rcall delay
	ldi R20,0
	rcall BCD
	out PORTD,R20
	ori R20,0x04
	out PORTB,R20
	rcall delay
	mov R20,R19
	rcall BCD
	out PORTD,R16
	ori R17,0x08
	out PORTB,R17
	rcall delay
    rjmp UPDW

    C2: 
    ldi R20,2
	rcall BCD
	out PORTD,R20
	ori R20,0x02
	out PORTB,R20
	rcall delay
	ldi R20,0
	rcall BCD
	out PORTD,R20
	ori R20,0x04
	out PORTB,R20
	rcall delay
	mov R20,R26
	rcall BCD
	out PORTD,R16
	ori R17,0x08
	out PORTB,R17
	rcall delay
	rjmp UPDW
	C3: 
	 rcall outofrange3  ;;precisei fazer isso para retirar o erro "branch relative out of range"
	 rjmp UPDW
	C4:
	 rcall outofrange4
	 rjmp UPDW
    C5:
     rcall outofrange5
	 rjmp UPDW

 outofrange3:	  
   ldi R20,3
	rcall BCD
	out PORTD,R20
	ori R20,0x02
	out PORTB,R20
	rcall delay
	ldi R20,0
	rcall BCD
	out PORTD,R20
	ori R20,0x04
	out PORTB,R20
	rcall delay
	mov R20,R21
	rcall BCD
	out PORTD,R16
	ori R17,0x08
	out PORTB,R17
	rcall delay
	ret

outofrange4: 
    ldi R20,4
	rcall BCD
	out PORTD,R20
	ori R20,0x02
	out PORTB,R20
	rcall delay
	ldi R20,0
	rcall BCD
	out PORTD,R20
	ori R20,0x04
	out PORTB,R20
	rcall delay
	mov R20,R22
	rcall BCD
	out PORTD,R16
	ori R17,0x08
	out PORTB,R17
	rcall delay
	ret


outofrange5:
    ldi R20,5
	rcall BCD
	out PORTD,R20
	ori R20,0x02
	out PORTB,R20
	rcall delay
	ldi R20,0
	rcall BCD
	out PORTD,R20
	ori R20,0x04
	out PORTB,R20
	rcall delay
	mov R20,R23
	rcall BCD
	out PORTD,R16
	ori R17,0x08
	out PORTB,R17
	rcall delay
	ret

   BCD:  
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
   ret

 ZERO:
  ldi R16,0xFC
  ret
  
  UM:
  ldi R16,0x18
  ret

  DOIS:
  ldi R16,0x6C
  ldi R17,0x01
  ret

  TRES:
  ldi R16,0x3C
  ldi R17,0x01
  ret

  QUATRO:
  ldi R16,0x98
  ldi R17,0x01
  ret
  
  CINCO:
  ldi R16,0xB4
  ldi R17,0x01
  ret

  SEIS:
  ldi R16,0xF1
  ldi R17,0x01
  ret

  SETE:
  ldi R16,0x1C
  rcall delay
  ret

  OITO:
  ldi R16,0xFC
  ldi R17,0x01
  ret

  NOVE:
  ldi R16,0x9C
  ldi R17,0x01
  ret

 delay:
  clr R31
  clr R30
 loop:
  dec R31
  brne loop
  dec R31
  brne loop
  ret
	 