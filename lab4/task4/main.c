//program created to test function myRDTSC(read internar cpu's timer) 
#include <stdio.h>

const int N = 10;

extern  unsigned long long myRDTSC(); //from source.s
extern  unsigned long long testMOV(); //from source.s

int main(void) {
	for(int i = 0; i < N; i++){
		unsigned long long start = myRDTSC();
		printf("printf #%d", i);
		unsigned long long end = myRDTSC();
		printf(" time: %llu\n", end-start);
	}
	for(int i = 0; i < N; i++){
		unsigned long long start = myRDTSC();
		write(1, "This will", 9);
		unsigned long long end = myRDTSC();
		printf(" time: %llu\n", end-start);
	}
	for(int i = 0; i < N; i++){
		printf("tmp++ time: %llu\n", testMOV());
	}
	return 0;
}
