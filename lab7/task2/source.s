.align 16
.data

.global tab

.global myRDTSC
.type myRDTSC, @function
myRDTSC:
	xorl %eax, %eax
	pushl %ebx #save %ebx cuz cpuid overwrites that
	cpuid
	rdtsc
	popl %ebx
	ret

.global add1
.type add1, @function
add1:
	pushl %ebx
	pushl %ebp
	movl 12(%esp), %ebp #ecx = row
	movl 16(%esp), %ebx #ecx = col

	movl (tab), %eax
	movl (%eax, %ebp, 4), %eax

	movl %eax, %ebp	
#	cflush (%ebp)
	cpuid
	rdtsc
	movl %eax, %ecx	

	movl $8, (%ebp, %ebx, 4)

	pushl %ecx
	cpuid
	rdtsc

	popl %ecx
	subl %ecx, %eax

	popl %ebp
	popl %ebx

	ret

