.align 16
.data

.global tab

.global clflush
.type clflush, @function
clflush:
	clflush (tab)
	clflush (tab + 300)
	ret


.global add1
.type add1, @function
add1:
	pushl %ebx
	pushl %ebp
	movl 12(%esp), %ebp #ebp = idx 
	
	cpuid
	rdtsc
	pushl %eax

	movl tab, %eax 
	movl $9, (%eax,%ebp,4) #tab[i] = 9

	cpuid
	rdtsc
	
	popl %ebx
	
	subl %ebx, %eax
	

	popl %ebp
	popl %ebx

	ret



