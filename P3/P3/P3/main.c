/*
 * P3.c
 *
 * Created: 15/06/2019 20:19:19
 * Author : José
 */ 
#define F_CPU 16000000UL
#define LCD_CLEARDISPLAY 0x01
#define LCD_RETURNHOME 0x02
#define LCD_ENTRYMODESET 0x04
#define LCD_DISPLAYCONTROL 0x08
#define LCD_FUNCTIONSET 0x20

// flags for display entry mode
#define LCD_ENTRYLEFT 0x02
#define LCD_ENTRYSHIFTDECREMENT 0x00

// flags for display on/off control
#define LCD_DISPLAYON 0x04
#define LCD_CURSOROFF 0x00
#define LCD_BLINKOFF 0x00

// flags for function set
#define LCD_4BITMODE 0x00
#define LCD_2LINE 0x08
#define LCD_5x8DOTS 0x00
#include <avr/io.h>
#include <util/delay.h>
#include <math.h>
#include <stdlib.h>

uint8_t _rs_pin = 12;
uint8_t _rw_pin = 255;
uint8_t _enable_pin = 11;
uint8_t _data_pins[8] = {2, 3, 4, 5, 0, 0, 0, 0};
uint8_t _displayfunction = LCD_4BITMODE | LCD_2LINE | LCD_5x8DOTS;
uint8_t _displaycontrol;
uint8_t _displaymode;

void lcd_write(uint8_t value){
	PORTD = value<<4;

	PORTB &=~(1<<3); // digitalWrite(_enable_pin, LOW);
	_delay_us(1);
	PORTB |= (1<<3); // digitalWrite(_enable_pin, HIGH);
	_delay_us(1);    // enable pulse must be >450ns
	PORTB &=~(1<<3); // digitalWrite(_enable_pin, LOW);
	_delay_us(100);   // commands need > 37us to settle
}

void lcd_write_byte(uint8_t value){
	lcd_write(value>>4);
	lcd_write(value);
}

void lcd_print(uint8_t value){
	PORTB |= (1<<4); // digitalWrite(_rs_pin, HIGH);
	lcd_write_byte(value);
	PORTB &=~(1<<4); // digitalWrite(_rs_pin, LOW);
}

void lcd_number(int num){
	int mil, cen, dec, uni;
	if(num>=1000 && num<10000){
		mil = num/1000;
		lcd_print(mil+48);
	}
	else mil = 0;
	if(num>=100){
		cen = (num%1000)/100;
		lcd_print(cen+48);
	}
	else cen = 0;
	if(num>=10){
		dec = (num%100)/10;
		lcd_print(dec+48);
	}
	else dec = 0;
	uni = num%10;
	lcd_print(uni+48);

}

void lcd_begin(){
	DDRB = 0b00011010;
	DDRD = 0b11110000;
	
	_delay_us(50000);
	// Now we pull both RS and R/W low to begin commands
	
	PORTB &=~(1<<4); // digitalWrite(_rs_pin, LOW);
	PORTB &=~(1<<3); // digitalWrite(_enable_pin, LOW);
	
	lcd_write_byte(LCD_FUNCTIONSET | _displayfunction);
	_delay_us(4500);  // wait more than 4.1ms
	
	lcd_write_byte(LCD_FUNCTIONSET | _displayfunction);  // second try
	_delay_us(150);
	
	lcd_write_byte(LCD_FUNCTIONSET | _displayfunction);  // third go
	
	lcd_write_byte(LCD_FUNCTIONSET | _displayfunction);  // finally, set # lines, font size, etc.
	
	_displaycontrol = LCD_DISPLAYON | LCD_CURSOROFF | LCD_BLINKOFF;  // turn the display on with no cursor or blinking default
	
	lcd_write_byte(LCD_DISPLAYCONTROL | _displaycontrol);
	
	lcd_write_byte(LCD_CLEARDISPLAY);// clear it off
	_delay_ms(2);  // this command takes a long time!
	
	_displaymode = LCD_ENTRYLEFT | LCD_ENTRYSHIFTDECREMENT;  // Initialize to default text direction (for romance languages)

	lcd_write_byte(LCD_ENTRYMODESET | _displaymode);  // set the entry mode
}

void balada(uint8_t discoteca){ //T = 7, W = 6, O = 5 , F = 4; PORTD
	if(discoteca == 0){
		PORTD = 0x00;
	}
	else if(discoteca == 1){ //T
		PORTD = 0x80;
	}
	else if(discoteca == 2){ //T*
		PORTD = 0x80;
		_delay_ms(250);
		PORTD = 0x00;
		_delay_ms(250);
	}
	else if(discoteca == 3){ //T + W*
		PORTD = 0xC0;
		_delay_ms(250);
		PORTD = 0x80;
		_delay_ms(250);
	}
	else if(discoteca == 4){//O
		PORTD = 0x20;
	}
	else if(discoteca == 5){//O*
		PORTD = 0x20;
		_delay_ms(250);
		PORTD = 0x20;
		_delay_ms(250);
	}
	else if(discoteca == 6){//O + W*
		PORTD = 0x60;
		_delay_ms(250);
		PORTD = 0x20;
		_delay_ms(250);
	}
	else if(discoteca == 7){//F
		PORTD = 0x10;
	}
	else if(discoteca == 8){//F*
		PORTD = 0x10;
		_delay_ms(250);
		PORTD = 0x10;
		_delay_ms(250);
	}
	else if(discoteca == 9){//F+W*
		PORTD = 0x50;
		_delay_ms(250);
		PORTD = 0x10;
		_delay_ms(250);
	}
}

uint8_t limitanteH(uint8_t ajusteH){
	if(ajusteH > 23) ajusteH = 00;
	if(ajusteH < 0) ajusteH = 23;
	return ajusteH;
}

uint8_t limitanteM(uint8_t ajusteM){
	if(ajusteM > 59) ajusteM = 00;
	if(ajusteM < 0) ajusteM = 59;
	return ajusteM;
}

uint8_t limitanteS(uint8_t ajusteS){
	if(ajusteS > 6) ajusteS = 0;
	if(ajusteS < 0) ajusteS = 6;	
	return ajusteS;
}

/*uint8_t diadasemana(uint8_t cod_dia){
	char dia[3];
	switch(cod_dia){
		case 0: dia = "DOM";
		case 1: dia = "SEG";
		case 2: dia = "TER";
		case 3: dia = "QUA";
		case 4: dia = "QUI";
		case 5: dia = "SEX";
		case 6: dia = "SAB";
	}
	return dia;
} */

void timer(uint8_t modo,uint8_t hora,uint8_t minuto,uint8_t sem){
	int flagb = 1; //flag botão
		hora = limitanteH(hora);
		minuto = limitanteM(minuto);
		sem = limitanteS(sem);
		balada(modo);
		//LCD
		if(!PINB3 && !PINB2) flagb = 1;
		if(PINB3 && flagb == 1){ // 11 = UP
			flagb = 0;
			if(modo == 1 || modo == 4 || modo == 7 ) hora = hora + 1;
			else if (modo == 2 || modo == 5 || modo == 8) minuto = minuto + 10;
			else if (modo == 3 || modo == 6 || modo == 9) sem = sem + 1;
		}
		if(PINB2 && flagb == 1){ // 10 = DOWN
			flagb = 0;
			if(modo == 1 || modo == 4 || modo == 7 ) hora = hora - 1;
			else if (modo == 2 || modo == 5 || modo == 8) minuto = minuto - 10;
			else if (modo == 3 || modo == 6 || modo == 9) sem = sem - 1;
		}
	}

void happyday(uint8_t dia){
	char diadehoje[] = "oie";
	if( dia == 0) diadehoje[] = "DOM";
	else if( dia == 1) diadehoje[] = "SEG";
	else if( dia == 2) diadehoje[] = "TER";
	else if( dia == 3) diadehoje[] = "QUA";
	else if( dia == 4) diadehoje[] = "QUI";
	else if( dia == 5) diadehoje[] = "SEX";
	else if( dia == 6) diadehoje[] = "SAB";  
}

	int main(void){
		uint8_t horaC,minutoC,semC;
		int estado = 0;
		DDRB = 0XF8;
		DDRD = 0XFC;
		lcd_begin();
		_delay_ms(1000);
		char texto[3] = "QUA";
		for(int n=0;n<3;n++){
			lcd_print(texto[n]);
			_delay_ms(100);
		}
		//executar run
		while(1){
			if(PINB0 || estado == 0){ // P8 = C
				//executar run
				estado = 0;
			}
			else if(estado == 1 && PINB1){ // P9 = M
				timer(estado,horaC,minutoC,semC);//timerH
				estado = 2;
			}
			else if(estado == 2 && PINB1){
				timer(estado,horaC,minutoC,semC);//timerM
				estado = 3;
			}
			else if(estado == 3 && PINB1){
				timer(estado,horaC,minutoC,semC);//Week
				estado = 4;
			}
			else if(estado == 4 && PINB1){
				timer(estado,horaC,minutoC,semC);//onH
				estado = 5;
			}
			else if(estado == 5 && PINB1){
				timer(estado,horaC,minutoC,semC);//executar onM
				estado = 6;
			}
			else if(estado == 6 && PINB1){
				timer(estado,horaC,minutoC,semC);//executar WeekOn
				estado = 7;
			}
			else if(estado == 7 && PINB1){
				timer(estado,horaC,minutoC,semC);//executar offH
				estado = 8;
			}
			else if(estado == 8 && PINB1){
				timer(estado,horaC,minutoC,semC);//executar offM
				estado = 9;
			}
			else if(estado == 9 && PINB1){
				timer(estado,horaC,minutoC,semC);//executar WeekOff
				estado = 0;
			}
		}
	}


