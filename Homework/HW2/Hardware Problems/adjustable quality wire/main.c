/**************************************************************************/
//Name:  main.c																														//
//Purpose:  Skeleton project with configuration for ADC, DAC, MCG and PIT	//
//Author:  Ethan Hettwer																									//
//Revision:  1.0 15Sept2014 EH Initial Revision														//
//Target:  Freescale K22f																									//
/**************************************************************************/

#include "MK22F51212.h"                 				//Device header
#include "MCG.h"																//Clock header
#include "TimerInt.h"														//Timer Interrupt Header
#include "ADC.h"																//ADC Header
#include "DAC.h"																//DAC Header

uint16_t adc_measurement;							//ADC is setup for 12-bit conversion (because DAC can only output 12-bit) but using 16-bit variable
uint8_t n = 10; // range of 0-11. Masks off (12-n) bits from LSB to MSB

void PIT0_IRQHandler(void){	//This function is called when the timer interrupt expires
	//Place Interrupt Service Routine Here
	ADC0->SC1[0] &= 0xE0; 	//Start conversion of channel 1
	//while(ADC_SC1_COCO(ADC0->SC1[0]));	//Wait until conversion is done
	adc_measurement = ADC0->R[0];				//Read results of conversion
	
	// flips value
	adc_measurement = adc_measurement >> n;
	adc_measurement = adc_measurement << n;

	DAC0->DAT[0].DATL = DAC_DATL_DATA0(adc_measurement & 0xFF);		//Set Lower 8 bits of Output
	DAC0->DAT[0].DATH = DAC_DATH_DATA1(adc_measurement >> 0x8);		//Set Higher 8 bits of Output
	
	NVIC_ClearPendingIRQ(PIT0_IRQn);							//Clears interrupt flag in NVIC Register
	PIT->CHANNEL[0].TFLG	= PIT_TFLG_TIF_MASK;		//Clears interrupt flag in PIT Register		

}

int main(void){
	MCG_Clock120_Init();
	ADC_Init();
	ADC_Calibrate();
	DAC_Init();
	TimerInt_Init();
	while(1){
		//Main loop goes here
	}
}
