STDIN = 0
STDOUT = 1
SYSREAD = 3
SYSWRITE = 4
SYSEXIT = 1

.data
hello_msg: .ascii "Hello darkness, my old friend.\n"
hello_msg_len = . - hello_msg

.text
.global _start

_start:
	movl $SYSWRITE, %eax
	movl $STDOUT, %ebx
	movl $hello_msg, %ecx 
	movl $hello_msg_len, %edx 
	int $0x80

	movl $SYSEXIT, %eax
	movl $0, %ebx
	int $0x80
