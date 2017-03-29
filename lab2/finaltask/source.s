#program implements Sieve of Eratosthenes
#the output is a bit table, where index of bit represents number.
#If bit is set that means that that number is prime
#example: for n = 8
#output: 0b10101111 -> 2, 3, 5, 7 are prime (we are ignoring bits with idx 0 and 1 of first byte)
#          ||||||||
#interp.   76543210
#data for testing: http://zak.ict.pwr.wroc.pl/materials/architektura/laboratorium%20AK2/Dane/lab_4.tgz

STDIN = 0
STDOUT = 1
SYSREAD = 3
SYSWRITE = 4
SYSEXIT = 1

.align 16
.bss
	buff_len = 1<<30 #in bits
	buff_in_bytes = buff_len/8
	buff: .zero buff_len

.text
.global main

main:
#fill buff with ones
	movl $(buff_in_bytes/4), %ecx
	init_buff:
		movl $0xffffffff, (buff-4)(,%ecx,4)
	loop init_buff


#%edi - j - outter loop 
#%edx - j*j 
#%ecx - i - inner loop

#for(uint j = 2;j*j < 2^N; j++)
	movl $2, %edi # j = 2
outter_loop:
	movl %edi, %eax 
	mul %eax # j*j
	movl %eax, %edx
	cmpl $buff_len, %edx
	jge outter_loop_end

	#check if bit number j(%edi) is set
		bt %edi, buff #check if bit j is set
		jnc inner_loop_end #skip if bit j isn't set

	#for(uint i = j*j; i < 2^N; i+=j) (not exactly...) 
		movl %edx, %ecx # i = j*j
	inner_loop:
		cmpl $buff_len, %ecx
		jge inner_loop_end

		#check if bit number i(%ecx) is set
			btr %ecx, buff #set bit i to 0
			addl %edi, %ecx # i += j

			jmp inner_loop

	inner_loop_end:
		incl %edi
		jmp outter_loop

outter_loop_end:

#print_buff
	movl $SYSWRITE, %eax
	movl $STDOUT, %ebx
	movl $buff, %ecx 
	movl $buff_in_bytes, %edx 
	int $0x80
	ret
	
#exit
	movl $SYSEXIT, %eax
	movl $0, %ebx
	int $0x80
