section .data; 

file db "./azucar.txt", 0
len equ 1024
hola_palabra: db 'Hola TARINGUEROS!!',10;
hola_tamanio: equ $-hola_palabra 
stringu times 9 db '*'

section .bss

buffer: resb 1024

section .text 

global _start 

_start: 
mov eax,4              ; call system 'write' id 4 
mov ebx,1              ; descriptor de archivo 1 = pantalla 
mov ecx,hola_palabra   ; guardo la cadena en un registro ecx 
mov edx,hola_tamanio   ; guardo la cadena en un registro edx 
int 80h                ; interrupcion para invocar al kernel 

	
mov	edx,9    ;message length
mov	ecx,stringu   ;message to write
mov	ebx,1    ;file descriptor (stdout)
mov	eax,4    ;system call number (sys_write)
int	0x80     ;call kernel

mov ebx, file	;name of the file  
mov eax, 5  
mov ecx, 0  
int 80h     
mov eax, 3  
mov ebx, eax
mov ecx, buffer 
mov edx, len    
int 80h     

mov eax, 4  
mov ebx, 1
mov ecx, buffer 
mov edx, len    
int 80h     
mov eax, 6  
int 80h



; Final del programa 
mov eax,1                    ; llamada del  sistema 'exit' 
mov ebx,0                    ; codigo de error 0 (No error)
int 80h                      ; interrupcion para invocar al kernel de Linux