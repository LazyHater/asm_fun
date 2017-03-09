#Made by Dominik Hofman and internet
#program converts hex string into int eg. ff -> 255

STDIN = 0
STDOUT = 1
STDERR = 2
SYSREAD = 3
SYSWRITE = 4
SYSEXIT = 1

.data 
 buff: .space 9,  0x00 # 5 cuz int consist of 4 bytes + 1 byte for '\n'
 error_msg: .ascii "Not valid input!\n"
 error_msg_len = . - error_msg
 .text
.global main
main:
	push %ebp
	mov %esp, %ebp #create stack frame

  call get_input
	pushl $9
	pushl $buff
	call print

	#magic stuff here
	movl $0, %ecx
	movl $0, %edx
	loop:
	sall $4, %edx #prepare edx for another byte
	movb buff(,%ecx,1), %al #load byte from buff
	#check if it is A-F
	cmp $'a', %eax
	jl skip
	cmp $'f', %eax
	jg skip
	
	#here we know that we got A-F
	sub $('a'-10), %eax
	add %eax, %edx
	jmp next

	skip:
	#check if we got 0-9
	cmp $'0', %eax
	jl not_valid
	cmp $'9', %eax
	jg not_valid

	#here we know that we got 0-9
	sub $('0'), %eax
	add %eax, %edx
	jmp next

	not_valid:
	pushl $error_msg_len
	pushl $error_msg
	call print
	jmp exit

	next:
	inc %ecx
	movb buff(,%ecx,1), %al #load byte from buff
	cmp $0xa, %eax #check if it is enter
  jne loop 
bexit:
  jmp exit

#[ msg ][msg_len][ebp]
#[ebp-8][ ebp-4 ][ebp]
print:
  movl $SYSWRITE, %eax
  movl $STDERR, %ebx
  movl -4(%ebp), %edx #msg_len
  #movl $error_msg_len, %edx #msg_len
  movl -8(%ebp), %ecx #msg
  #movl $error_msg, %ecx #msg
  int $0x80
  ret $8

get_input:
  movl $SYSREAD, %eax
  movl $STDIN, %ebx
  movl $buff, %ecx
  movl $9, %edx
  int $0x80
  ret

exit:
  movl $SYSEXIT, %eax
  movl $0, %ebx
  int $0x80
