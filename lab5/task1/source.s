.align 16
.text

#function takes 2 float, and return their multiplication
.global multiply
.type multiply, @function

multiply:
	pushl %ebp
	movl %esp, %ebp
	finit
	flds 8(%ebp) #x
	fmuls 12(%ebp) #y
	popl %ebp
	ret

#function takes 16bit value and sets control register
.global setControlRegister
.type setControlRegister, @function

setControlRegister:
	pushl %ebp
	movl %esp, %ebp
	fldcw 8(%ebp) #set control register
	popl %ebp
	ret

#function returns 16bit control register 
.global getControlRegister
.type getControlRegister, @function

getControlRegister:
	pushl %ebp
	movl %esp, %ebp

	xorl %eax, %eax
	subl $2, %esp
	fstcw (%esp) #store control register
	movw (%esp), %ax
	addl $2, %esp

	movl %ebp, %esp
	popl %ebp
	ret

#function returns 16bit status register 
.global getStatusRegister
.type getStatusRegister, @function

getStatusRegister:
	pushl %ebp
	movl %esp, %ebp

	xorl %eax, %eax
	subl $2, %esp
	fstsw (%esp) #set control register
	movw (%esp), %ax
	addl $2, %esp

	movl %ebp, %esp
	popl %ebp
	ret

