#Made by Dominik Hofman and internet
#program implements Caesar cipher on upper case letters

STDIN = 0
STDOUT = 1
STDERR = 2
SYSREAD = 3
SYSWRITE = 4
SYSEXIT = 1
SIZE_OF_ROTATION = 5

.data 
 buff: .byte 0x00

 .text
.global main
main:
  call get_byte
	#magic stuff here

	#check if it is a uppercase
	cmp $'A', (buff)
	jl skip
	cmp $'Z', (buff)
	jg skip
	
	#here we know that we got upper case letter
	add $SIZE_OF_ROTATION, (buff)

	#check if we get over the "Z" letter
	cmp $'Z', (buff)
	jng skip
	#if so subb the difference needef for rotate
	sub $('Z'-'A'+1), (buff)

	skip:
  call print_byte
	cmp $0xa, (buff) #check if it is enter
  jne main 
  call exit

print_byte:
  movl $SYSWRITE, %eax
  movl $STDOUT, %ebx
  movl $buff, %ecx
  movl $1, %edx
  int $0x80
  ret

get_byte:
  movl $SYSREAD, %eax
  movl $STDIN, %ebx
  movl $buff, %ecx
  movl $1, %edx
  int $0x80
  ret

exit:
  movl $SYSEXIT, %eax
  movl $0, %ebx
  int $0x80
