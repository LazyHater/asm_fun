#task_1.s : reverst the case of letter eg. 'A' -> 'a'; 'a' -> 'A'
#Made by Dominik Hofman and internet

STDIN = 0
STDOUT = 1
STDERR = 2
SYSREAD = 3
SYSWRITE = 4
SYSEXIT = 1

.data
	prompt_msg: .ascii "Hello, pls feed me with string:\n"
	prompt_msg_len = . - prompt_msg

	buff_len = 200
	buff: .space buff_len, 0x00

.text
.global main

main:
#	.byte 0xcc
	call print_prompt_msg
	call get_input
	call test_fnc
	call flip_cases
	call print_input
	call exit

print_prompt_msg:
	movl $SYSWRITE, %eax
	movl $STDERR, %ebx
	movl $prompt_msg, %ecx 
	movl $prompt_msg_len, %edx 
	int $0x80
	ret

get_input:
	movl $SYSREAD, %eax
	movl $STDIN, %ebx
	movl $buff, %ecx 
	movl $buff_len,  %edx 
	int $0x80
	ret

	
print_input:
	movl $SYSWRITE, %eax
	movl $STDOUT, %ebx
	movl $buff, %ecx 
	movl $buff_len, %edx 
	int $0x80
	ret

test_fnc:
	movl $0, %ecx
	cmp %ecx, %ecx
	jnz test_fnc	
	ret

#reg usage: al - holds value of acctual byte;  ebx - holds buff; ecx - counter; edx - holds addr of acctual byte
flip_cases:
	movl $0, %eax
	movl $0, %ecx
	movl $buff, %ebx
	loop_start:
		#check if its end of a string (0 byte)
		lea  (%ebx, %ecx, 1), %edx   
		movb (%edx), %al
		test %al, %al 
		jz loop_exit

		#check if its is a capital letter
		cmpb $'A', %al
		jl not_a_capital #jump if al<'A'
		cmpb $'Z', %al
		jg not_a_capital #jump if al>'Z'
		#here we are sure that in al we have capital letter
		addb $0x20, (%edx) # 0x20 = 'a' - 'A'
		not_a_capital:

		#check if its is a capital letter
		cmpb $'a', %al
		jl not_letter #jump if al<'a'
		cmpb $'z', %al
		jg not_letter #jump if al>'z'
		#here we are sure that in al we have small letter
		subb $0x20, (%edx) # 0x20 = 'a' - 'A'
		not_letter:

		inc %ecx
		jmp loop_start
	loop_exit:
	ret

exit:
	movl $SYSEXIT, %eax
	movl $0, %ebx
	int $0x80
