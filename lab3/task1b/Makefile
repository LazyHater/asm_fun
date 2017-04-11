SOURCE = main.cpp 
OBJECT = $(SOURCE:.s=.o)
#EXEC = $(SOURCE:.s=)
EXEC = prog

all:
	g++ main.cpp -c -o main.o
	as -o test.o test.s
	g++ main.o test.o -o prog

test: all
	./prog
	

debug: gcc
	gdb --command=gdbscript -q  $(EXEC)

clean:
	rm main.o test.o prog
