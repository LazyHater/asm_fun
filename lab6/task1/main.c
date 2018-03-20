#include <stdio.h>
#include <stdint.h>

extern unsigned long long myRDTSC();

extern float f1[4]; 
extern float xvec[4]; 
extern float xdt[4]; 
extern float result[4]; 

extern void load(); //from source.s
extern void iterateSSE(); //from source.s
extern void endSSE(); //from source.s

void prepare(float from, float to, int N){
	float width = to - from;
	float deltaX = width / N;
	for(int i = 0; i < 4; i++){
		xvec[i] = from + (width / 4.0f) * (float)i; 	
		xdt[i] = deltaX;
		result[i] = 0;
	}
}

float funcVal(float x){
	return (1-x*x)/x;
}
void iterate(){
	for(int i = 0; i < 4; i++){
		float a = funcVal(xvec[i]);
		float b = funcVal(xvec[i] + xdt[i]);
		result[i] += (a+b)*xdt[i];
		xvec[i] += xdt[i];
	}
}

float integratec(float from, float to, int N){
	prepare(from, to, N);
	for(int i = 0; i < N/4; i++){
		iterate();
	}
	return (result[0] + result[1] + result[2] + result[3])/2.0f;
}

float integratesse(float from, float to, int N){
	prepare(from, to, N);
	load();
	for(int i = 0; i < N/4; i++){
		iterateSSE();
	}
	endSSE();
	return (result[0] + result[1] + result[2] + result[3])/2.0f;
}

int main(void) {
	float from = 1, to = 2;
	int N = 1024;
	unsigned long long cTime = myRDTSC();
	float resultc = integratec(from, to, N);
	cTime = myRDTSC() - cTime;
	unsigned long long sseTime = myRDTSC();
	float resultsse = integratesse(from, to, N);
	sseTime = myRDTSC() - sseTime;
	printf("integrate from x=%.2f, to %.2f, with %i rectanglesa:\nc result: %.20f done in: %llu\n sse result: %.20f done in: %llu\n", from, to, N, resultc, cTime, resultsse, sseTime  );

	return 0;
}
