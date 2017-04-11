STDIN = 0
STDOUT = 1
SYSREAD = 3
SYSWRITE = 4
SYSEXIT = 1

.data
	prompt_msg: .asciz "Hello.\n"
	prompt_msg_len = . - prompt_msg

	buff_len = 20
	buff: .space buff_len, 0x00

.text
.global main

main:
	pushl $prompt_msg
	call puts
debug:
	movl $0xffffffff, %eax
	movl $0xffffffff, %ebx
	addl %ebx, %eax
	call exit

print_prompt_msg:
	ret


#stack: [our_string][ret][ebp]
#                             ^ 
#                            [ebp]
#on ecx we will have lenght of string
#function prints asscii string, string have to end with null byte

puts:
	#create local stack frame
	push %ebp
	movl %esp, %ebp

	movl $0, %edx
loop:
	movl 8(%ebp), %ecx
	movb (%ecx,%edx,1), %bl
	
	inc %edx

	testb %bl, %bl
	jnz loop	

	dec %edx

	movl $SYSWRITE, %eax
	movl $STDOUT, %ebx
	int $0x80

	pop %ebp
	
	ret $4
exit:
	movl $SYSEXIT, %eax
	movl $0, %ebx
	int $0x80
