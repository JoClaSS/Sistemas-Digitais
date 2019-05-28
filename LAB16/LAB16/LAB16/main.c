/*
 * LAB16.c
 *
 * Created: 19/05/2019 15:02:52
 * Author : José
 */ 
#define F_CPU 16000000UL
#define PI 3.1415
#include <avr/io.h>
#include <math.h>
#include <util/delay.h>
#include <avr/interrupt.h>
//===========================MACROS=====================//
#define set_bit(Y,bit_x) (Y|=(1<<bit_x))   
#define clr_bit(Y,bit_x) (Y&=~(1<<bit_x))   
#define tst_bit(Y,bit_x) (Y&(1<<bit_x))     
#define cpl_bit(Y,bit_x) (Y^=(1<<bit_x))
// =====================================================//


/*void frenquecia(uint8_t freq)  //unsigned int 1 byte
{
	TCCR1B |= (1<<CS12) |  (1<<WGM12); // prescala 256, CTC
	TIMSK1 |= (1<<OCIE1A);
	OCR1A = ((F_CPU/freq*2*256)-1);
}  
*/
//frequencia = 60hz
void retang(){
	PORTD = 0xFC;
	_delay_ms(8);
	PORTD = 0x00;
	_delay_ms(8);
}

void triang(){
	int i,k;
	for(i = 255;i>=0;i--){
	  k = i & 0xfc;
	  PORTD = k;
	  _delay_ms(0.03);
	}
	for(i = 0;i<256;i++){
	 k = i & 0xfc;
	  PORTD = k;
	  _delay_ms(0.03);
	}
}

void seno(){
	float i,w,s;
	int x;
	w = 2*PI*60;
	for(i = 0;i<=PI;i = i + 0.0001){
	s = sin(w*i);
	x = s*127 +127;
	PORTD = x;
	_delay_ms(1);
	}
}


int main(void)
{
	//Garantir ; T = 1/60 = 0,018s = 18ms
	DDRD = 0xFC;
	while(1){
		if(PINC == 0x00)
		triang();
		else if(PINC == 0X01)
		retang();
		else
		seno();
	}
}


