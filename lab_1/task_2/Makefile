SOURCE = task_2.s
OBJECT = $(SOURCE:.s=.o)
EXEC = $(SOURCE:.s=)

all: $(EXEC) 

gcc: $(SOURCE)
	gcc -g -m32 $(SOURCE) -o $(EXEC) 

test: gcc
	./test.sh

$(EXEC): $(OBJECT) 
	ld $(OBJECT) -m elf_i386 -o $(EXEC) 

$(OBJECT): $(SOURCE)
	as --32 $(SOURCE) -o $(OBJECT) 

clean:
	rm $(EXEC) $(OBJECT)
