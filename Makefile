example: example.o
	ld -o example example.o 
example.o: example.asm
	nasm -f elf64 example.asm
clean:
	rm -f *.o
	rm -f example