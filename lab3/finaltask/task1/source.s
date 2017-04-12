#program calls scanf and printf on int, char, char*
.section .rodata
	format_string_printf: .asciz "int: %d char:%c char*:%s\n"
	format_string_scanf: .asciz "%d %c %s"

.data
	int: .int 0
	char: .zero 1
	string: .zero 50

.text
.global main

main:
	pushl $string
	pushl $char
	pushl $int
	pushl $format_string_scanf
	call scanf
	addl $16, %esp

	pushl $string
	pushl char
	pushl int
	pushl $format_string_printf
	call printf
	addl $16, %esp

	movl $0, %eax
	ret
