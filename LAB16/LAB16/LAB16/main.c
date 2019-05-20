/*
 * LAB16.c
 *
 * Created: 19/05/2019 15:02:52
 * Author : José
 */ 
#define F_CPU 16000000UL
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


void frenquecia(uint8_t freq)  //unsigned int 1 byte
{
	TCCR1B |= (1<<CS12) |  (1<<WGM12); // prescala 256, CTC
	TIMSK1 |= (1<<OCIE1A);
	OCR1A = ((F_CPU/freq*2*256)-1);
}
int init_PWM(int DCa,int DCb)
{
 TCCR1B |= (1<<CS10) |  (1<<WGM12); //sem prescala, CTC 
 TIMSK1 |= (1<<OCIE1A) | (1<<OCIE1B); //OUTPUT compara com IRQ
 OCR1A = DCa;
 OCR1B = DCb;
 return 0;
}

void notseno(){
	int BITi = 2;
	if(DDRC == 0X01){
		PORTD = 0XFC;
		_delay_ms(9);  //duty cycle 50%
		PORTD = 0X00;
		_delay_ms(9);
	}
	else if(DDRC == 0X10){
		for(BITi = 2;BITi <= 7;BITi++){
			set_bit(PORTD,BITi);
			_delay_ms(2); // 18/12 = 1.5 = 2
		}
		for(BITi = 7;BITi >= 2;BITi--){
			clr_bit(PORTD,BITi);
			_delay_ms(2);
		}
	}
}

void inputseno(int x,int y){
	int i = 0;
	for(i=0;i<5;i++){
	 init_PWM(x,y);
	 x = x + 100;
	 y = y - 100;
	}
	for(i=5;i>0;i--){
	 init_PWM(x,y);
	 x = x - 100;
	 y = y + 100;
	}
}
ISR(TIMER1_COMPA_vect){
   notseno();
}
ISR(TIMER1_COMPB_vect){
   inputseno(500,500);	
}

int main(void)
{
    //Garantir ; T = 1/60 = 0,018s = 18ms
    DDRD = 0xFC;
	init_PWM(500,500);
	sei();
	while(1){
	  }
	return 0;
}


