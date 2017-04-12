#include <stdio.h>

int main(){
	int a;
	char c;
	char str[50];

	scanf("%d %c %s", &a, &c, str);
	printf("int:%d char:%c char*:%s\n", a, c, str);
	return 0;
}
