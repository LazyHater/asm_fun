//program calculates integrate of function (1-x*x)/x
//with standard FPU, and with SSE

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

extern unsigned int add1(unsigned int idx);
extern unsigned long long clflush(); 

const int N = 1000;

int* tab;

int main(void) {
	tab = malloc(sizeof(int)*N);
	
	for(int i = 0; i < N; i++)
		tab[i] = i;

	unsigned int time1, time2, time3, time4;
	for(int i = 0; i < 20; i++) {
		clflush();
		time1 = add1(0);	
		time2 = add1(0);	
		time3 = add1(300);	
		time4 = add1(300);	
		
		printf("{%u %u, %u %u}\n",
			 time1, time2, time3, time4);
	}	

//	for(int i = 0; i < N; i++)
//		printf("%d ", tab[i]);

	puts("\n");
	
	free(tab);
	return 0;
}
