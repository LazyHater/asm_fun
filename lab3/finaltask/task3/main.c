//demonstration of using variables declared in asm/c in c/asm
int asm_var = 1;

extern int exit_code; //from source.s
extern int myAsmFunc();	//from source.s

int main(void) {
	return exit_code;
//	return myAsmFunc();// exit_code + asm_var;
}
