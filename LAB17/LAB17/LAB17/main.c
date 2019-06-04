/*
 * LAB17.c
 *
 * Created: 20/05/2019 13:39:36
 * Author : José
 */ 
#define F_CPU 16000000UL
#include <avr/io.h>
#include <util/delay.h> 
#include <math.h>

void setup(){
	DDRD = 0xFC;
	DDRB = 0x03;
	ADCSRA = (1<<ADEN) | (1<<ADPS2) | (1<<ADPS1);
	ADMUX = (1<<REFS0);
}

int main(void){
	double n,adcO;
	unsigned int final;
	double cosseno;
	setup();
	while(1) {                     
		for(n = 0;n <= 6.28;n = n + 0.01){
		ADCSRA |= (1<<ADSC);
		while (ADCSRA & (1<<ADSC));
		adcO = (ADC>>3);			    //int
		cosseno = (adcO*cos(n))+127.00; //float
		final = cosseno;			        //int
		PORTD = ((final & 0b0000000000111111)<<2); 
		PORTB = ((final & 0b0000000011000000)>>6);
		}
	}
	return 0;                     
}



	


