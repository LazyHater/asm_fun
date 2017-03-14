# program reads from stdin 4 digit value in base ten, then converts it to base 16 and prints it out
# made by Dominik Hofman, and the internet

STDIN = 0
STDOUT = 1
SYSREAD = 3
SYSWRITE = 4
SYSEXIT = 1

.data
	invalid_input_msg: .ascii "Invalid input!\n"
	invalid_input_msg_len = . - invalid_input_msg

	input_buff_len = 20
	input_buff: .space input_buff_len, 0x00

	output_buff_len = 5
	output_buff: .space output_buff_len , 0x0a
	#debug
	#output_buff_len = 8 
	#output_buff: .ascii "Hello2.\n"

.text
.global main

main:
	call get_input
	call ascii_to_uint #after this, in eax we have uint representation on inputed string
	call uint_to_ascii #after this, in output buffer we got ascii representation in hex of value
	call print_output
	call exit


# eax - value in memory  ebx - current character
ascii_to_uint:
	mov $0, %eax
	mov $0, %ecx
	mov $0, %edx
	mov $input_buff, %ebx 
	ascii_to_uint_loop:
debug:

	cmpb $'0', (%ebx) #if (ebx < 0) goto invalid input
  jl invalid_input

	cmpb $'9', (%ebx) #if (ebx > 0) goto invalid input
  jg invalid_input


	#here we are sure that we got valid ascii digit 0-9
  #subb '0' to get value in memory	
	subb $'0', (%ebx)
	#multiply eax by 10 and add to eax just calculated
	movw $10, %cx
	mul %cx
	movb (%ebx), %dl
	addl %edx, %eax

	
	inc %ebx 
	cmpb $0xa, (%ebx) #if ebx contains '\n' (0xa) break loop
	jne ascii_to_uint_loop
	ret

#in eax we have value to convert to ascii
uint_to_ascii:
	mov $4, %ecx
	
	uint_to_ascii_loop:
	
	mov %eax, %edx
	dec %ecx
	shl $2, %cl 
  shr %cl, %edx # edx = edx >> ecx
	shr $2, %cl
	inc %ecx
	and $0xf, %edx # edx = edx && 0xf (and with mask)
	#here in edx we have value of one digit

	addb $'0', %dl
	movl $4, %ebx
	subl %ecx, %ebx


  cmp $'9', %dl
	jle skip
	addb $39, %dl
skip:

	movb %dl, output_buff(,%ebx,1)

	loop uint_to_ascii_loop

	ret

invalid_input:
	call print_invalid_input_msg
	call exit

print_invalid_input_msg:
  pusha
	movl $SYSWRITE, %eax
	movl $STDOUT, %ebx
	movl $invalid_input_msg, %ecx 
	movl $invalid_input_msg_len, %edx 
	int $0x80
	popa
	ret

get_input:
	movl $SYSREAD, %eax
	movl $STDIN, %ebx
	movl $input_buff, %ecx 
	movl $input_buff_len,  %edx 
	int $0x80
	ret

	
print_output:
	movl $SYSWRITE, %eax
	movl $STDOUT, %ebx
	movl $output_buff, %ecx 
	movl $output_buff_len, %edx 
	int $0x80
	ret

	
exit:
	movl $SYSEXIT, %eax
	movl $0, %ebx
	int $0x80
