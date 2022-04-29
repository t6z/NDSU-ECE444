#include "MK22F51212.h"   	//Device header
#include "MCG.h"						//Clock header
#include "TimerInt.h"				//Timer Interrupt Header
#include "ADC.h"						//ADC Header								
#include "DAC.h"						//DAC Header
#include "BUTTONS.h"				//BUTTONS Header
#include "RGBLED.h"					//RGB LED Header
#include "coef.h"						//Coefficients Header
#include <stdbool.h>				//Boolean data types

uint16_t adc_meas = 0;
int16_t y = 0;
uint8_t i = 0;
uint8_t n = 0;
bool fs = 0; // filter select: either digital wire or FIR FWLS filter

void PIT0_IRQHandler(void){	//This function is called when the timer interrupt expires
	GPIOA->PSOR |= GPIO_PSOR_PTSO(0x1u << 1); // Turn on Red LED  
	ADC0->SC1[0] &= 0xE0; 	//Start conversion of channel 1
	adc_meas = ADC0->R[0];  //Read channel 1 after conversion
	
	if(!fs){ //if filter select is not set to digital wire
		// first stage
		y = B[0]*adc_meas;
				
		// rest of stages
		for(i=1;i<Lbuf;i++){
			y = y + B[i]*buf[(n+(Lbuf-i))%Lbuf];
		}
		
		buf[n%Lbuf] = adc_meas; // store new measurement into circular buffer
		
	}	
	
	// may need to move this into if statement
	n = (n+1)&(Lbuf); // masking index cap of 127 as only 0->127 mem locations
	
	DAC0->DAT[0].DATL = DAC_DATL_DATA0(adc_meas & 0xFFu);						//Set Lower 8 bits of Output
	DAC0->DAT[0].DATH = DAC_DATH_DATA1((adc_meas >> 0x8)&0xFFu);		//Set Upper 8 bits of Output
		
	NVIC_ClearPendingIRQ(PIT0_IRQn);							//Clears interrupt flag in NVIC Register
	PIT->CHANNEL[0].TFLG	= PIT_TFLG_TIF_MASK;		//Clears interrupt flag in PIT Register	
		
	GPIOA->PCOR |= GPIO_PCOR_PTCO(0x1u << 1); // Red LED = 0
}

// K++ BUTTON
void PORTB_IRQHandler(void){ //This function might be called when the SW3 is pushed
	if(fs){ //if filter select is equal to 0 (digital wire)
		fs = true; //set equal to zero (loop back around to lowest starting passband freq)
	}else{fs=false;}
	
	// clear buffer just to be safe?
	for(i=0;i<Lbuf;i++){buf[i]=0;}
	
	NVIC_ClearPendingIRQ(PORTB_IRQn);  	//CMSIS Function to clear pending interrupts on PORTB	
	PORTB->ISFR = (0x1u << 17);					//clears PORTB ISFR flag
}

int main(void){
	RGBLED_Init();
	BUTTONS_Init();
	MCG_Clock120_Init();
	ADC_Init();
	DAC_Init();
	TimerInt_Init();
	while(1){
		
	}
}
