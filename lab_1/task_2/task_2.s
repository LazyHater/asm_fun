#Made by Dominik Hofman and internet
#program converts hex string into int eg. ff -> 255

STDIN = 0
STDOUT = 1
STDERR = 2
SYSREAD = 3
SYSWRITE = 4
SYSEXIT = 1

.data 
 buff: .space 5,  0x00 # 5 cuz int consist of 4 bytes + 1 byte for '\n'
 error_msg: .ascii "Not valid input!\n"
 error_msg_len = . - error_msg
 .text
.global main
main:
	push %ebp
	mov %esp, %ebp #create stack frame

  call get_input
	pushl $5
	pushl buff
	call print

	#magic stuff here
	movl $0, %ecx
	movl buff, %ebx
	#check if it is A-F
	loop:
	cmp $'A', buff(,%ecx,1)
	jl skip
	cmp $'F', buff(,%ecx,1)
	jg skip
	
	#here we know that we got A-F
	jmp next

	skip:
	#check if we got 0-9
	cmp $'0', buff(,%ecx,1)
	jl not_valid
	cmp $'9', buff(,%ecx,1)
	jg not_valid

	#here we know that we got 0-9
	jmp next

	not_valid:
	pushl $error_msg_len
	pushl $error_msg
	call print
	jmp exit

	next:
	inc %ecx
	cmp $0xa, buff(,%ecx,1) #check if it is enter
	
  jne loop 

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
  movl buff, %ecx
  movl $5, %edx
  int $0x80
  ret

exit:
  movl $SYSEXIT, %eax
  movl $0, %ebx
  int $0x80
