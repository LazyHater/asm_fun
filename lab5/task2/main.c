#include <stdio.h>
#include <stdint.h>
#include <limits.h>
#include <float.h>

extern float multiply(float, float); //from source.s
extern uint16_t getControlRegister();
extern uint16_t getStatusRegister();
extern void setControlRegister(uint16_t);

float multiply2(float x, float y){
	return x*y;
}; //from source.s
float div(float a, float b){
	return a / b;		
}

void printBinary(uint16_t what){
	for(int i = 15; i >=0 ; i--){
		if(what&(1 << i))
			printf("1");
		else
			printf("0");
	}
}

// for input 2 3 generates precision exception flag
// for input 2 0 generates divide by 0 exception flag
int main(void) {

	float x, y;
	printf("\npls gib me two floats: ");
	scanf("%f %f", &x, &y);

	uint16_t controlRegisterContentBefore = getControlRegister();	
	float result = x/y;

	uint16_t statusRegisterContentBefore = getStatusRegister();
	uint16_t statusRegisterContentAfter = getStatusRegister();

	printf("\nresult:%f/%f %f\n",x,y, result) ;

	//setControlRegister(0);
	printf("control register before set: ");
	printBinary(controlRegisterContentBefore);
	printf("\nstatus register before set: ");
	printBinary(statusRegisterContentBefore);
	printf("\nstatus register after set: ");
	printBinary(statusRegisterContentAfter);
	printf("\n");
	return 0;
}
