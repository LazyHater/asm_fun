all: input

input: input.o
	ld input.o -o input

input.o: input.s 
	as input.s -o input.o

clean:
	rm input input.o
