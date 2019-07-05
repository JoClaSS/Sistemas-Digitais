/*
 * I2C.c
 *
 * Created: 08/06/2019 16:34:06
 * Author : José
 */
#define F_CPU 16000000UL
#include <avr/io.h>
#include <util/delay.h>
//#include <util/twi.h>


void initI2C(){
	//set SCL to 400kHz
	TWSR = 0x00;
	TWBR = 0x0C;
	TWCR = (1<<TWEN);
}	

void startI2C()
{
	TWCR = (1<<TWINT)|(1<<TWSTA)|(1<<TWEN);
	while ((TWCR & (1<<TWINT)) == 0);
}

void stopI2C()
{
	TWCR = (1<<TWINT)|(1<<TWSTO)|(1<<TWEN);
}

void I2Cwrite(uint8_t u8data)
{
	TWDR = u8data;
	TWCR = (1<<TWINT)|(1<<TWEN);
	while ((TWCR & (1<<TWINT)) == 0);
}

uint8_t I2Cread(){
	TWCR = (1<<TWINT)|(1<<TWEN);
	while ((TWCR & (1<<TWINT)) == 0);
	if(TWSR == 0x40){ 
	return TWDR;
	}
	else
	return 0;
}
uint8_t I2CACK(void)
{
	TWCR = (1<<TWINT)|(1<<TWEN)|(1<<TWEA);
	while ((TWCR & (1<<TWINT)) == 0);
	return TWDR;
}

uint8_t I2CNACK(void)
{
	TWCR = (1<<TWINT)|(1<<TWEN);
	while ((TWCR & (1<<TWINT)) == 0);
	return TWDR;
}

void MasterTransmitter(uint8_t addr_s, uint8_t data_s){
		  initI2C();
		  startI2C();
		  I2Cwrite(addr_s);
		  I2Cwrite(data_s);
		  stopI2C();
		  _delay_ms(1);
}

/*void MasterReceived(){
	initI2C();
	startI2C();
	I2Cread();
	I2Cwrite();
	stopI2C();
	_delay_ms(1);
} */

int main(){
	while(1){
		
	}
}