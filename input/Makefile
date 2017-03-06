all: input

input: input.o
	ld input.o -m elf_i386 -o input

input.o: input.s 
	as --32 input.s -o input.o

clean:
	rm input input.o
