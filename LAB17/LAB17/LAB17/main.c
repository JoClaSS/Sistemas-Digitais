/*
 * LAB17.c
 *
 * Created: 20/05/2019 13:39:36
 * Author : José
 */ 
#define F_CPU 16000000UL
#define PI 3.1415
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>


void setup(){
	DDRD = 0XFC;
}

void cosseno(){
	int w,i,n,xc,yc; //w = 2*pi*f;
	w = 2*PI*60; //AJUSTAR F
	for(n = 0;n < 10; n++){
		for(i = 0; i < 2*PI; i = i + 0.001){
			xc = i*PORTD0;
			yc = xc * cos(n*i*w);
		    yc = yc & 0xFC;
			PORTD = yc;
		}
	}
}
int main(void)
{
	setup();
    while (1) 
    {
		cosseno(); 
    }
}

