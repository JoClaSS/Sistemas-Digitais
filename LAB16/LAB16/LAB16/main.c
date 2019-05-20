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
//===========================MACROS=====================//
#define set_bit(Y,bit_x) (Y|=(1<<bit_x))   
#define clr_bit(Y,bit_x) (Y&=~(1<<bit_x))   
#define tst_bit(Y,bit_x) (Y&(1<<bit_x))     
#define cpl_bit(Y,bit_x) (Y^=(1<<bit_x))
// =====================================================//


int main(void)
{
	int BITi;
    //Garantir ; T = 1/60 = 0,018s = 18ms
    DDRD = 0xFC;
	while(1){
	if(DDRC == 0X01){
		PORTD = 0XFC;
		_delay_ms(9);  //duty cycle 50%
		PORTD = 0X00;
		_delay_ms(9);
	}
	else
	  for(BITi = 2;BITi <= 7;BITi++){
	     set_bit(PORTD,BITi);
	     _delay_ms(2); // 18/12 = 1.5 = 2  
	  }
	  for(BITi = 7;BITi >= 2;BITi--){
		  clr_bit(PORTD,BITi);
		  _delay_ms(2);
	  }
	}
	return 0;
}