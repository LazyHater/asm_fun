STDIN = 0
STDOUT = 1
SYSREAD = 3
SYSWRITE = 4
SYSEXIT = 1

.data
	prompt_msg: .ascii "Hello.\n"
	prompt_msg_len = . - prompt_msg

	buff_len = 20
	buff: .space buff_len, 0x41

.text
.global _start

_start:
	call print_prompt_msg
	call get_input
	call print_input
	call exit

print_prompt_msg:
	movl $SYSWRITE, %eax
	movl $STDOUT, %ebx
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

	
exit:
	movl $SYSEXIT, %eax
	movl $0, %ebx
	int $0x80
