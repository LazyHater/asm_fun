#include <stdio.h>
#include <stdint.h>
#include <limits.h>
#include <float.h>
#define P24 (0)
#define P53 (2)
#define P64 (3)

extern void multiply(); //from source.s
extern uint16_t getControlRegister();
extern uint16_t getStatusRegister();
extern void setControlRegister(uint16_t);

void printBinary(uint16_t what){
	for(int i = 15; i >=0 ; i--){
		if(what&(1 << i))
			printf("1");
		else
			printf("0");
	}
}

// for input 2 3 generates precision exception flag

void printDoubleBinary(double what){
long long fl = *(long long*)&what;
	for(int i = 63; i >=0 ; i--){
		if(fl&(1 << i))
			printf("1");
		else
			printf("0");
	}
}

// for input 2 3 generates precision exception flag
// for input 2 0 generates divide by 0 exception flag
int main(void) {
	multiply();

	double x = 6549861686161.0, y = 65468461616.0, result;
	printf("\npls gib me two floats: ");
	scanf("%lf %lf", &x, &y);

	uint16_t statusRegisterContentBefore = getStatusRegister();


	uint16_t statusRegisterContentAfter = getStatusRegister();
    	uint16_t tmp = getControlRegister();
	tmp = tmp & (0b111110011111111);
	 result = x/y;

	printf("\nresult:\n");
	printDoubleBinary(result);
	puts("");

	setControlRegister(tmp);
	 result = x/y;
	uint16_t controlRegisterContentBefore = getControlRegister();	

	printf("\nresult:%lf/%lf %lf\nx:\n",x,y, result) ;

	printDoubleBinary(x);
	printf("\ny:\n");
	printDoubleBinary(y);
	printf("\nresult:\n");
	printDoubleBinary(result);
	puts("");

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
