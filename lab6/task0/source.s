.align 16
.text
f1: .float 1.2
		.float 2.4
		.float 3.4 
		.float 5.6

.global load
.type load, @function

#load 4 floates from structure v4
load:
	pushl %ebp
	movl %esp, %ebp
	movups 8(%ebp), %xmm0
	#movaps (f1), %xmm0
	popl %ebp
	ret

#function takes 2 float, and return their multiplication
.global multiply
.type multiply, @function

multiply:
	pushl %ebp
	movl %esp, %ebp
	finit
	movl (f1), %eax
	movl %eax, 8(%ebp)
	flds 8(%ebp) #x
	fmuls 12(%ebp) #y
	popl %ebp
	ret
