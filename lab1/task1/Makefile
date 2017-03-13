SOURCE = task1.s
OBJECT = $(SOURCE:.s=.o)
#EXEC = $(SOURCE:.s=)
EXEC = prog

all: $(EXEC) 

gcc: $(SOURCE)
	gcc -g -m32 $(SOURCE) -o $(EXEC) 

tests: gcc
	./tests.sh

$(EXEC): $(OBJECT) 
	ld $(OBJECT) -m elf_i386 -o $(EXEC) 

$(OBJECT): $(SOURCE)
	as --32 $(SOURCE) -o $(OBJECT) 

clean:
	rm $(EXEC) $(OBJECT)

clear:
	rm $(EXEC) $(OBJECT)
