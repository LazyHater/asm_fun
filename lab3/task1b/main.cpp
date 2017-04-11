int myFunc(int b){
	asm("movl $10, %eax \n\t \
			 addl -8(%ebp), %eax");
}
extern "C" int asmFunc();

int main(){
	
	return asmFunc() + myFunc(3);
}

