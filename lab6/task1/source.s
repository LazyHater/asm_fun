.align 16
.data
.global f1
f1: 		.float 1.0
		.float 1.0
		.float 1.0 
		.float 1.0

.global xvec
xvec: .space 128
.global xdt
xdt: .space 128
.global result
result: .space 128
.text


.global load
.type load, @function
#load 4 floates from structure v4
load:
	movaps (xvec), %xmm1
	movaps (xdt), %xmm2
	movaps (result), %xmm3
	movaps (f1), %xmm4


.global iterateSSE
.type iterateSSE, @function
iterateSSE:
	movaps %xmm4, %xmm0 #xmm0 = 1
	movaps %xmm1, %xmm5 #xmm5 = x
	mulps %xmm5, %xmm5 #x*x
	subps %xmm5, %xmm0 #1-x*x
	divps %xmm1, %xmm0 #(1-x*x)/x

	movaps %xmm5, %xmm6 #a == xmm6

	addps %xmm2, %xmm1 #x += dx

	movaps %xmm4, %xmm0 #xmm0 = 1
	movaps %xmm1, %xmm5 #xmm5 = x
	mulps %xmm5, %xmm5 #x*x
	subps %xmm5, %xmm0 #1-x*x
	divps %xmm1, %xmm0 #(1-x*x)/x
	movaps %xmm5, %xmm7 #b == xmm7

	movaps %xmm6, %xmm3 #result = a
	addps %xmm7, %xmm3# a+b
	mulps %xmm2, %xmm3#(a+b)*dt
	ret

.global endSSE
.type endSSE, @function
endSSE:
	movaps %xmm3, (result)
	ret

.global myRDTSC
.type myRDTSC, @function
myRDTSC:
	xorl %eax, %eax
	pushl %ebx #save %ebx cuz cpuid overwrites that
	cpuid
	rdtsc
	popl %ebx
	ret
