all: task_1

gcc: task_1.s
	gcc -g -m32 task_1.s -o task_1

task_1: task_1.o
	ld task_1.o -m elf_i386 -o task_1

task_1.o: task_1.s 
	as --32 task_1.s -o task_1.o

clean:
	rm task_1 task_1.o
