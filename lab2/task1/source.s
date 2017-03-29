#program adds 2 big numbers, where one digit is 32bit long


STDIN = 0
STDOUT = 1
SYSREAD = 3
SYSWRITE = 4
SYSEXIT = 1

.data
	prompt_msg: .asciz "Hello.\n"
	number_1: .long 0xf0f0f0f1
		  .long 0x00000000
	number_1_len = 2
	number_2: .long 0x0f0f0f0f
		  .long 0x00000000
	number_2_len = 2

.text
.global main

main:
	pushl $prompt_msg
	call puts
	pushl $number_2_len
	pushl $number_2
	pushl $number_1_len
	pushl $number_1
	call add_big_numbers
	call exit

#function adds number 1 to number 2 and stores result in number 1
#warning if lenght of number 1 is diffrent than 2, make sure that longer number
#is number nr 1
#[numb_2_len][numb_2][numb_1_len][numb_1][ret][ebp]
#                         			   ^ 
#                           			 [ebp]
#on edx we will have lenght of string

add_big_numbers:
	pushl %ebp
	movl %esp, %ebp

	movl $0, %ecx
	movl $0, %edx

debug:
loop_2:
	cmpl %ecx, 12(%ebp) # if our counter reachd number of "digits" then end
	je exit

	movl 8(%ebp), %eax # in eax numb 1
	movl 16(%ebp), %ebx # in ebx numb 2
	leal (%eax, %ecx, 4), %eax # in eax numb 1
	leal (%ebx, %edx, 4), %ebx # in ebx numb 2
	movl (%ebx), %ebx
	pushf
	adcl %ebx, (%eax)
	popf
	inc %ecx
	inc %edx
	jmp loop_2

	movl %ebp, %esp
	popl %ebp
	ret $16
#function prints asscii string, string have to end with null byte
#stack: [our_string][ret][ebp]
#                             ^ 
#                            [ebp]
#on edx we will have lenght of string

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
