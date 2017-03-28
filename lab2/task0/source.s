#program reads stdin data in format: 
#first byte: how many numbers
#second byte: width of number in bytes
#rest: data in little endian
#example [2][2][0xaa][0xbb][0xcc][0xdd]
#means that we have 2 numbers, 2 bytes each : 0xbbaa, 0xddcc
#then program sorts that table and prints to stdout

STDIN = 0
STDOUT = 1
SYSREAD = 3
SYSWRITE = 4
SYSEXIT = 1

.data

	nNumbers: .byte 0x00 #how many numbers
	wNumbers: .byte 0x00 #width in bytes of number
	buff_len = 66000 #in that format (256*256) buff with lenght of 66000 is enought
	buff: .space buff_len, 0x00

.text
.global main

main:
	call get_nNumbers
	call get_wNumbers
	call get_data
	call sort
	call print_buff
	call exit

#-4(%ebp) (i) - inner loop, -8(%ebp)(n) - outter loop
sort:
	push %ebp
  movl %esp, %ebp
	subl $8, %esp

	#n = len(tab)
	xor %eax, %eax
  movb (nNumbers), %al	
	movl %eax, -8(%ebp)

outter_loop:
	
	#while(n>1):
  movl -8(%ebp), %eax
	cmpl $1, %eax
	jng sort_end

#for i in range(0, n-1)
  movl $0, -4(%ebp)
movl $0, %ecx
inner_loop:
	
  movl -8(%ebp), %eax # eax = n
	decl %eax # eax--
	cmpl -4(%ebp), %eax # eax - i  
	jge inner_loop_end # if (i >= (n - 1) ) jmp inner_loop_exit




incl %ecx
#if tab[i] < tab[i+1]
#swap

	jmp inner_loop

inner_loop_end:
	# n = n - 1
	decl -8(%ebp)
	jmp outter_loop

sort_end:	
debug:
	leave
	ret
#1 arg - idx
#returns in eax address of byte by index
get_address_by_idx:
	movl 4(%esp), %eax
	mulb (wNumbers)
	addl $buff, %eax
	ret $4

get_nNumbers:
	movl $SYSREAD, %eax
	movl $STDIN, %ebx
	movl $nNumbers, %ecx 
	movl $1,  %edx 
	int $0x80
	ret

get_wNumbers:
	movl $SYSREAD, %eax
	movl $STDIN, %ebx
	movl $wNumbers, %ecx 
	movl $1,  %edx 
	int $0x80
	ret

get_data:

	movl $buff, %ecx 

get_data_loop:

	movl $SYSREAD, %eax
	movl $STDIN, %ebx
	movl $1,  %edx 
	int $0x80
	inc %ecx
	cmpl $0, %eax #check for end of file
	jne get_data_loop

	ret

	
print_buff:
	movb (nNumbers), %al
	movb (wNumbers), %bl
	mul %bl 
	xor %edx, %edx
	movw %ax, %dx
	movl $SYSWRITE, %eax
	movl $STDOUT, %ebx
	movl $buff, %ecx 
	int $0x80
	ret

	
exit:
	movl $SYSEXIT, %eax
	movl $0, %ebx
	int $0x80
