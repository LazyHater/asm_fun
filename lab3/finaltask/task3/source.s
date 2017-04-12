.global exit_code #using asm variable in asm
	exit_code: .long 0x000000ff

.align 16
.text

.global asm_var #from main.c

.global myAsmFunc
.type myAsmFunc, @function

myAsmFunc:
	movl asm_var, %eax 
	ret
