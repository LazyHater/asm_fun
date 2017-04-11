#program samples of using variables and functions from func.c in assembly code
# %ebp, %ebx, %edi, %esi, %esp -- need to be saved in function, 
# and then restored
STDIN = 0
STDOUT = 1
SYSREAD = 3
SYSWRITE = 4
SYSEXIT = 1

#.align 16

.data
	prompt_msg: .ascii "Hello.\n"
	prompt_msg_len = . - prompt_msg

.section .rodata
	printf_msg: .asciz "I'm %d workin\n"

.text
.global myCFunc #declared at func.c
.global myCVariable #declared at func.c
.global main

main:
#calling function from libc
	pushl $5
	pushl $printf_msg
	call printf
	addl $8, %esp
 
#calling function located in func.c
	pushl myCVariable #reference to global variable from func.c
	pushl $35
	call myCFunc
	addl $8, %esp
	movb %al, (prompt_msg)
	
#print_prompt
	movl $SYSWRITE, %eax
	movl $STDOUT, %ebx
	movl $prompt_msg, %ecx 
	movl $prompt_msg_len, %edx 
	int $0x80

#exit
	movl $SYSEXIT, %eax
	movl $0, %ebx
	int $0x80
