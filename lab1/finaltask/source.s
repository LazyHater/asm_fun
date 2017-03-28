STDIN = 0
STDOUT = 1
SYSREAD = 3
SYSWRITE = 4
SYSEXIT = 1

.data
	buff_in: .byte 0x00 
	buff_out: .byte 0x00 

.text
.global main

main:
	call get_input
debug:
	xor %eax, %eax #eax = 0
	movb (buff_in), %al
	shr $4, %eax #shift 
	#here we have in al value of first hex digit
	addb $'0', %al
	#here if digit was <=9 we are done
	#if not, we need to convert it to a-f ascii value
	cmpb $'9', %al # if(al <= '9')  goto skip;
	jle skip	
	#here we need to convert it to 'a' - 'f' range
	addb $7, %al

	skip:
	movb %al, (buff_out)

	call print_buff

	xor %eax, %eax
	movb (buff_in), %al
	and $0xf, %eax #applay mask 
	#here we have in al value of second hex digit
	addb $'0, %al
	#here if digit was <=9 we are done
	#if not, we need to convert it to a-f ascii value
	cmpb $'9', %al # if(al <= '9')  goto skip;
	jle skip_second	
	#here we need to convert it to 'a' - 'f' range
	addb $7, %al

	skip_second:
	movb %al, (buff_out)
	movb %al, (buff_out)

	call print_buff

	movb $' ', (buff_out)

	call print_buff
	jmp main

	call exit


get_input:
	movl $SYSREAD, %eax
	movl $STDIN, %ebx
	movl $buff_in, %ecx 
	movl $1,  %edx 
	int $0x80
	#if sysread return 0, it mean that we meet eof, exit then
	cmp $0, %eax
	jz exit
	ret

	
print_buff:
	movl $SYSWRITE, %eax
	movl $STDOUT, %ebx
	movl $buff_out, %ecx 
	movl $1, %edx 
	int $0x80
	ret

	
exit:
	movl $SYSEXIT, %eax
	movl $0, %ebx
	int $0x80
