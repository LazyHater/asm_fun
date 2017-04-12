.align 16
.text

#function template
.global myRDTSC
.type myRDSTC, @function

myRDTSC:
	xorl %eax, %eax
	pushl %ebx //save %ebx cuz cpuid overwrites that
	cpuid
	rdtsc
	popl %ebx
	ret

