/*
 * LAB17.c
 *
 * Created: 20/05/2019 13:39:36
 * Author : José
 */ 
#define F_CPU 16000000UL
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#define LED_ON  PORTB |= (1<<PORTB1)
#define LED_OFF PORTB &= ~(1<<PORTB1)

void PWMbegin(int cmpA,int cmpB){
	TCCR1B |= (1<<CS10) | (1<<WGM12);
	TIMSK1 |= (1<<OCIE1A) | (1<<OCIE1B);
	OCR1A = cmpA;
	OCR1B = cmpB;
}

ISR(TIMER1_COMPA_vect){
	LED_ON;
	sei();
}

ISR(TIMER1_COMPB_vect){
	LED_OFF;
	sei();
}

int main(void)
{
	DDRB = PINB1;
    PWMbegin(900,500);
	sei();
    while (1) 
    {
    }
}

