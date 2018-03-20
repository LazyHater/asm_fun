//program calculates integrate of function (1-x*x)/x
//with standard FPU, and with SSE

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

extern unsigned int add1(unsigned int row, unsigned int col);
extern unsigned int add2(unsigned int idx);

const int N = 100;

int* tab;

int main(void){
	tab = malloc(sizeof(int)*N);
	
	
	for(int i = 0; i < N; i++)
		tab[i] = i;
	add1(0);	

	for(int i = 0; i < N; i++)
		tab[i] = i;
	
	free(tab);
	return 0;
}
