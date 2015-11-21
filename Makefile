all: example prgrep 
example: example.asm
	nasm -f elf example.asm
	ld -m elf_i386 -o example example.o
	rm -f example.o 
	#./example	
prgrep: args.asm
	nasm -f elf -F dwarf -g args.asm
	ld -m elf_i386 -o prgrep args.o
	rm -f args.o
	./prgrep anitalavalatinax
clean:
	rm -f *.o
	rm -f example
	rm -f prgrep
recompile:
	rm -f example
	rm -f prgrep
	rm -f *.o
	make all