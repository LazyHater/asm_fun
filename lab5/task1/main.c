#include <stdio.h>
#include <stdint.h>

extern float multiply(float, float); //from source.s
extern uint16_t getControlRegister();
extern uint16_t getStatusRegister();
extern void setControlRegister(uint16_t);

float multiply2(float x, float y){
	return x*y;
}; //from source.s
extern void setControlFpuRegister(uint_16); //from source.s

int main(void) {
	float x, y;
	printf("pls gib me two floats: ");
	scanf("%f %f", &x, &y);
	printf("ty\nx=%f, y=%f, x*y=%f\n", x, y, multiply(x,y));

	int statusRegisterContent = getStatusRegister();
	int controlRegisterContentBefore = getControlRegister();
	setControlRegister(0);
	int controlRegisterContentAfter = getControlRegister();

	printf("status register before set: %#x\n", statusRegisterContent);
	printf("control register before set: %#x\n", controlRegisterContentBefore);
	printf("control register after set: %#x\n", controlRegisterContentAfter);
	return 0;
}
