// program reads cpu's 64bits timer thanks to function written in asm 
#include <stdio.h>

extern  unsigned long long myRDTSC();
int main(void) {
	long long tmp = myRDTSC();
	printf("%llu\n", tmp);
	return 0;
}
