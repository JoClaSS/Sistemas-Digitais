/*
 * GccApplication1.c
 *
 * Created: 04/06/2019 13:52:34
 * Author : José
 */ 

#define F_CPU 16000000UL
#include <avr/io.h>
#include <util/delay.h>
#include <math.h>

int setupA0(){
	unsigned int adcA0;
	DDRD = 0xFC;
	DDRB = 0x03;
	ADCSRA = (1<<ADEN) | (1<<ADPS2) | (1<<ADPS1);
	ADMUX = (1<<REFS0);
	ADCSRA |= (1<<ADSC);
	while (ADCSRA & (1<<ADSC));
	adcA0 = (ADC>>3);
	return adcA0;
}

int setupA1(){
	unsigned int adcA1;
	DDRD = 0xFC;
	DDRB = 0x03;
	ADCSRA = (1<<ADEN) | (1<<ADPS2) | (1<<ADPS1);
	ADMUX = (1<<REFS0) | (1<<MUX0);
	ADCSRA |= (1<<ADSC);
	while (ADCSRA & (1<<ADSC));
	adcA1 = (ADC>>3);
	return adcA1;
}

int main(void)
{
	unsigned long int SAD,SAD0,A0,A1;
	unsigned long int SAD1 = 0;
    while(1) 
    {
		int i;
		for(i = 0;i<200;i++){
		A0 = setupA0();
		A1 = setupA1();
		SAD0 = (A0 - A1);
		SAD1 = SAD1 + SAD0;
	    SAD = SAD1;
		SAD1 = 0;
		PORTD = ((SAD & 0b0000000000111111)<<2);
		PORTB = ((SAD & 0b0000000011000000)>>6);
		}
    }
	    

}

