.align 16
.text

#function template
.global myRDTSC
.type myRDSTC, @function

myRDTSC:
	xorl %eax, %eax
	pushl %ebx
	cpuid
	rdtsc
	popl %ebx
	ret

#function template
.global testMOV
.type testMOV, @function

testMOV:
	xorl %eax, %eax
	pushl %ebx

	cpuid
	rdtsc

	movl %eax, %esi
	movl %edx, %edi

	movl 4(%esp), %eax 

	xorl %eax, %eax
	cpuid
	rdtsc
	
	subl %esi, %eax #esp points to edx, esp+4 to eax
	sbbl %edi, %edx #esp points to edx, esp+4 to eax

	popl %ebx
	ret

