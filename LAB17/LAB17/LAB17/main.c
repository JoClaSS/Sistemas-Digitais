/*
 * LAB17.c
 *
 * Created: 20/05/2019 13:39:36
 * Author : José
 */ 
#define F_CPU 16000000UL // 1Mhz
#include <avr/io.h>
#include <stdlib.h>
#include <math.h>
#include <avr/interrupt.h>
#define pi 3,1415
#define CMAX 100u

volatile unsigned int x=1 ;
volatile int newx=0 ;
volatile unsigned int counter = 0;
unsigned char  x1;


//void saida();

void setup(){
	DDRD = 0b11111100;
	ADMUX = 0b00100000;
	ADCSRA = 0b11101010; 
	ADCSRB = 0;
    TCCR1A = 0;
	TCCR1B = 5;
    TCCR1C = 0;
    TIMSK1 = 2;
    OCR1AH = 0;
    OCR1AL = 4;
    sei();
}

int main()
{
    while (1) 
    {		
		saida();
   } 
}


void saida(){
x1 = x>>2; //Deslocando 2 para esquerda
PORTD = x1;	

		}
return ;
		
}


ISR(ADC_vect){
	
	newx = ADCH;
	ADCSRA = 0b11101010; //by 2 division
	return;
}

ISR(TIMER1_COMPA_vect){
	TCNT1H = 0;
	TCNT1L = 0;
	counter++;
	double newc = (counter/pi);
	newx = newx/2;
	x = (newx*cos(newc))+127;
	if (counter == CMAX){counter = 0;}
	return;	
}

