#include "MK22F51212.h"   	//Device header
#include "MCG.h"						//Clock header
#include "TimerInt.h"				//Timer Interrupt Header
#include "ADC.h"						//ADC Header								
#include "DAC.h"						//DAC Header
#include "BUTTONS.h"				//BUTTONS Header
#include "RGBLED.h"					//RGB LED Header
#include "coef280.h"				//Coefficients Header

uint16_t adc_meas = 0;
uint16_t k = 0;
uint8_t fs = 0x0;
float x,v,y = 0;

void PIT0_IRQHandler(void){	//This function is called when the timer interrupt expires
	GPIOA->PSOR |= GPIO_PSOR_PTSO(0x1u << 1); // Turn on Red LED
	ADC0->SC1[0] &= 0xE0; 	//Start conversion of channel 1
	adc_meas = ADC0->R[0];  //Read channel 1 after conversion
	
	if(fs!=0x4){ //if filter select is not set to digital wire
		
		// First Stage
		v = (G[fs]*(((float)adc_meas)-((float)2048))) - A[fs][0][0]*buf[0][0] - A[fs][0][1]*buf[0][1]; //compute 'middle-man' variable 'v'
		y = v + B[fs][0]*buf[0][0] + buf[0][1]; //compute output of filter stage y
		buf[0][1] = buf[0][0]; //cycle buffer (n-1) to (n-2)
		buf[0][0] = v; //input 'v' into buffer (n-1)
		
		// Rest of Stages
		for(k=1;k<K;k++){ //for each stage of filter
			v = y - A[fs][k][0]*buf[k][0] - A[fs][k][1]*buf[k][1]; //compute 'middle-man' variable 'v'
			y = v + B[fs][k]*buf[k][0] + buf[k][1]; //compute output of filter stage y
			buf[k][1] = buf[k][0]; //cycle buffer (n-1) to (n-2)
			buf[k][0] = v; //input 'v' into buffer (n-1)
		}
		
		adc_meas = (uint16_t)(y+2048); // mask y for output
	} //end of if statement
	
	DAC0->DAT[0].DATL = DAC_DATL_DATA0(adc_meas & 0xFFu);		//Set Lower 8 bits of Output
	DAC0->DAT[0].DATH = DAC_DATH_DATA1((adc_meas >> 0x8)&0xFFu);		//Set Higher 8 bits of Output
		
	NVIC_ClearPendingIRQ(PIT0_IRQn);							//Clears interrupt flag in NVIC Register
	PIT->CHANNEL[0].TFLG	= PIT_TFLG_TIF_MASK;		//Clears interrupt flag in PIT Register	
		
	GPIOA->PCOR |= GPIO_PCOR_PTCO(0x1u << 1); // Red LED = 0
}

// K++ BUTTON
void PORTB_IRQHandler(void){ //This function might be called when the SW3 is pushed
	if(fs==0x4){ //if filter select is equal to 4 (digital wire)
		fs = 0x0; //set equal to zero (loop back around to lowest starting passband freq)
	}else{fs++;}
	
	for(k=0;k<K;k++){
		buf[k][0]=0;
		buf[k][1]=0;
	}
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
