
#include "MK22F51212.h"                 				//Device header
#include "MCG.h"																//Clock header
#include "TimerInt.h"														//Timer Interrupt Header
#include "DAC.h"																//DAC Header
#include "ADC.h"
//#include "BUTTONS.h"														//BUTTONS Header
//#include "RGBLED.h"															//RGB LED Header

uint16_t adc_meas;

void PIT0_IRQHandler(void){	//This function is called when the timer interrupt expires
	//Place Interrupt Service Routine Here
	ADC0->SC1[0] &= 0xE0; 	//Start conversion of channel 1
	
	DAC0->DAT[0].DATL = DAC_DATL_DATA0(ADC0->R[0] & 0xFF);		//Set Lower 8 bits of Output
	DAC0->DAT[0].DATH = DAC_DATH_DATA1(ADC0->R[0] >> 0x8);		//Set Higher 8 bits of Output
	
	NVIC_ClearPendingIRQ(PIT0_IRQn);							//Clears interrupt flag in NVIC Register
	PIT->CHANNEL[0].TFLG	= PIT_TFLG_TIF_MASK;		//Clears interrupt flag in PIT Register	
}

//// K++ BUTTON
//void PORTB_IRQHandler(void){ //This function might be called when the SW3 is pushed

//	
//	NVIC_ClearPendingIRQ(PORTB_IRQn);              				//CMSIS Function to clear pending interrupts on PORTB	
//	PORTB->ISFR 							= (0x1u << 17);
//		
//}

//// K-- BUTTON
//void PORTC_IRQHandler(void){ //This function might be called when the SW2 is pushed
//	
//	
//	NVIC_ClearPendingIRQ(PORTC_IRQn);              				//CMSIS Function to clear pending interrupts on PORTC
//	PORTC->ISFR 							= (0x1u << 1);
//}

int main(void){
	MCG_Clock120_Init();
	//RGBLED_Init();
	//BUTTONS_Init();
	ADC_Init();
	DAC_Init();
	TimerInt_Init();
	while(1){
		
	}
}
