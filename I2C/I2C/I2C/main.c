/*
 * I2C.c
 *
 * Created: 08/06/2019 16:34:06
 * Author : José
 */
#define F_CPU 16000000UL
#define F_SCL 10000000UL
#define PRESCALE 1
#define TWBR_val ((((F_CPU/F_SCL)/PRESCALE) - 16)/2)
#include <avr/io.h>
#include <util/delay.h>
#include <util/twi.h>


void i2c_init(){
	DDRC = (1<<PINC5)|(1<<PINC4);
	TWBR = (uint8_t)TWBR_val;
	_delay_ms(10);
}

uint8_t i2c_start(uint8_t address){
	TWCR = 0;
	TWCR = (1<<TWINT) | (1<<TWSTA) | (1<<TWEN);	
	while(!(TWCR &  (1<<TWINT))){};
  	if((TWSR & 0xF8) != TW_START){ return 1;}
	TWDR = address;
	TWCR = (1<<TWINT) | (1<<TWEN);
	while(!(TWCR &  (1<<TWINT))){};
	uint8_t twst = TW_START & 0xF8;
	if((twst != TW_MT_SLA_ACK) && (twst != TW_MR_SLA_ACK)) return 1;
	return 0;
}

uint8_t i2c_write(uint8_t data){
	TWDR = data;
	TWCR = (1<<TWINT) | (1<<TWEN);
	while(!(TWCR &  (1<<TWINT))){};
	if((TWSR & 0xF8) != TW_MT_SLA_ACK)return 1;
	return 0;
}

void i2c_stop(void){
	TWCR = (1<<TWINT) | (1<<TWSTO) | (1<<TWEN);
}

int main(void){
	i2c_init();
	while(1){
		i2c_start(0x01);
		i2c_write(15);
		i2c_stop();
		_delay_ms(1);
	}
}


/*
uint8_t i2c_read_ack(void){
	TWCR = (1<<TWINT) | (1<<TWEN) | (1<<TWEA);
	while(!(TWCR &  (1<<TWINT)));
	return TWDR;
}

uint8_t i2c_read_nack(void){
	TWCR = (1<<TWINT) | (1<<TWEN);
	while(!(TWCR &  (1<<TWINT)));
	return TWDR;
} */