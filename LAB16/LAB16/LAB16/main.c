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

void retang(){
	PORTD=0XFC;
	_delay_ms(8);
	PORTD = 0X00;
	_delay_ms(8);
}

void triang(){
	int i;
	for(i = 2;i<8;i++){
		set_bit(PORTD,i);
		_delay_ms(0.9);
	}
	for(i = 8;i>2;i--){
		clr_bit(PORTD,i);
		_delay_ms(0.9);
	}
}

void seno(){
	int w,i,m;    //w = 2*pi*f
	w = 2*PI*60;
	for(i = 0; i<=PI;i = i + 0.1){
	m = sin(w*i);
	m = m & 0b11111100;
	PORTD = m;
	}
}
int main(void)
{
	//Garantir ; T = 1/60 = 0,018s = 18ms
	DDRD = 0xFC;
	DDRC = 0X00;
	while(1){
		if(PINC == 0X01){
		retang();
		}
		else if(PINC == 0X02){
		triang();
		}
		else{
	    seno();
		}
	}
	return 0;
}


