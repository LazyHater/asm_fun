STDIN = 0
STDOUT = 1
SYSREAD = 3
SYSWRITE = 4
SYSEXIT = 1

.data
	buff_len = 1024
	buff_in_bytes = buff_len/8
	buff: .space buff_len, 0xff

.text
.global main

main:
	call generate
	call print_buff
	call exit

#%ecx - j 
#%edi - i

generate:
#	pushl %ebp
#	movl %esp, %ebp
#	sub $8, %esp 

#for(int j = 2;j*j < 2^N; j++ )
	movl $2, %ecx # j = 2
	
outter_loop:
	movl %ecx, %eax 
	mul %ax # j*j
	cmpl $buff_len, %eax
	jge outter_loop_end
#check if bit number j is set

	xor %eax, %eax
	pushl %ecx
	movl %ecx, %edx
	shr $16, %edx #get older 16bit in dx
	movw %cx, %ax #get younger 16bit in ax
	movw $8, %cx #get 8 in cx
	div %cx #div by cx (8)
	popl %ecx
	#now in ax we have byte offset
	#in dx bit offset
	addl $buff, %eax #offset of byte, in %edx offset of bit
	
	movl $1, %ebx
	xchg %cl, %dl
	shl %cl, %ebx
	xchg %cl, %dl
	andb (%eax), %bl
	cmpb $0, %bl
	je inner_loop_end	
	#bt %edx, %eax
	#if cf is not set skip
	#jnc inner_loop_end
#for(int i = j; i < 2^N; i+=j )
	movl %ecx, %edi # i = j


inner_loop:
	addl %ecx, %edi # i += j
	cmpl $buff_len, %edi
	jge inner_loop_end

	xor %eax, %eax
	pushl %ecx
	movl %edi, %ecx
	movl %ecx, %edx
	shr $16, %edx #get older 16bit in dx
	movw %cx, %ax #get younger 16bit in ax
	movw $8, %cx #get 8 in cx
	div %cx #div by cx (8)
	popl %ecx
	#now in ax we have byte offset
	#in dx bit offset
	addl $buff, %eax # offset of byte, in %edx offset of bit
debug:
	#btr %edx, %eax
	movl $1, %ebx
	xchg %cl, %dl
	shl %cl, %ebx
	xchg %cl, %dl
	not %ebx
	andb %bl,(%eax)


	jmp inner_loop

inner_loop_end:
	incl %ecx
	jmp outter_loop
outter_loop_end:
	ret







	popl %ebp

print_buff:
	movl $SYSWRITE, %eax
	movl $STDOUT, %ebx
	movl $buff, %ecx 
	movl $buff_in_bytes, %edx 
	int $0x80
	ret

	
exit:
	movl $SYSEXIT, %eax
	movl $0, %ebx
	int $0x80
