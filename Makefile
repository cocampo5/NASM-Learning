all: example exe 
example: example.asm
	nasm -f elf example.asm
	ld -m elf_i386 -o example example.o
	rm -f example.o 	
exe: args.asm
	nasm -f elf args.asm
	ld -m elf_i386 -o exe args.o
	rm -f args.o
clean:
	rm -f *.o
	rm -f example
	rm -f exe