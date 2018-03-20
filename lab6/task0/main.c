#include <stdio.h>
#include <stdint.h>

extern float multiply(float, float); //from source.s

typedef struct {
	float f1;
	float f2;
	float f3;
	float f4;
} V4;
void lele(V4* xd){
	xd->f1 = 2;
}
extern void load(V4*); //from source.s

float multiply2(float x, float y){
	return x*y;
}; //from source.s

int main(void) {
	V4 vec;
	vec.f1 = 1;
	vec.f2 = 2;
	vec.f3 = 3;
	vec.f4 = 4;
	load(&vec);
	float x, y;
	printf("pls gib me two floats: ");
	scanf("%f %f", &x, &y);
	printf("ty\nx=%f, y=%f, x*y=%f\n", x, y, multiply(x,y));

	return 0;
}
