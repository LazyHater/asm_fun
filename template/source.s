STDIN = 0
STDOUT = 1
SYSREAD = 3
SYSWRITE = 4
SYSEXIT = 1

.align 16

.data
	prompt_msg: .ascii "Hello.\n"
	prompt_msg_len = . - prompt_msg

	buff_len = 20
	buff: .zero buff_len

.text
.global main

main:
	call print_prompt_msg
	call get_input
	debug:
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
