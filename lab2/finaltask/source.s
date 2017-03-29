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

.data
	buff_len = 1<<10 #in bits
	buff_in_bytes = buff_len/8
	buff: .space buff_len, 0xff

.text
.global main

main:
#%edi - j - outter loop 
#%ecx - i - inner loop

	debug:
#for(uint j = 2;j*j < 2^N; j++)
	movl $2, %edi # j = 2
outter_loop:
	movl %edi, %eax 
	mul %ax # j*j
	cmpl $buff_len, %eax
	jge outter_loop_end

#check if bit number j(%edi) is set
	movl %edi, %eax
	movl %eax, %ebx
	shrl $3, %eax #deal with 3 younger bytes, same as divide by 8
	andl $0b111, %ebx #get only 3 younger bytes, same as modulo 8
	#now in %eax we have offset for byte, and in %ebx offset of bit in that byte
	addl $buff, %eax #add buff offset
	bt %ebx, (%eax) #check if bit j is set
	jnc inner_loop_end #skip if bit j isn't set
	

#for(uint i = j; i < 2^N; i+=j) (not exactly...) 
	movl %edi, %ecx # i = j
inner_loop:
	addl %edi, %ecx # i += j
	cmpl $buff_len, %ecx
	jge inner_loop_end

#check if bit number i(%ecx) is set
	movl %ecx, %eax
	movl %eax, %ebx
	shrl $3, %eax #deal with 3 younger bytes, same as divide by 8
	andl $0b111, %ebx #get only 3 younger bytes, same as modulo 8
	#now in %eax we have offset for byte, and in %ebx offset of bit in that byte
	addl $buff, %eax #add buff offset
	btr %ebx, (%eax) #set bit i to 0

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
