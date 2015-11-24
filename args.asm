MAXARGS     equ     5 ; 1 = program path 2 = 1st arg  3 = 2nd arg etc...
sys_exit    equ     1 ; Llamadas de sistema 
sys_read    equ     3
sys_write   equ     4
stdin       equ     0
stdout      equ     1
stderr      equ     3

SECTION     .data

;szErrMsg    db      "Too many arguments.  The max number of args is 4", 10
;ERRLEN      equ     $-szErrMsg ;Bloque de codigo si quiero limitar argumentos

szLineFeed  dw      10 ;un \n
noArgus: dw 'No hay nada para buscar! Usage: exe -e | -f | -i',10;Mensaje a mostrar si no hay args
noArgusLong: equ $-noArgus ;longitud

SECTION     .text ;Main del programa

global      _start

_start:

    nop
    push    ebp
    mov     ebp, esp
    cmp     dword [ebp + 4], 1
    je      NoArgs                           ; no args entered
    ; uncomment the following 2 lines to limit args entered
    ; and set MAXARGS to Total args wanted + 1
    ; cmp     dword [ebp + 4], MAXARGS        ; check total args entered
    ; ja      TooManyArgs                     ; if total is greater than MAXARGS, show error and quit
    mov     ebx, 3

DoNextArg:  

    mov     edi, dword [ebp + 4 * ebx]
    test    edi, edi
    jz      Exit                            ;Si es == 0
    call    GetStrlen
    push    edx                             ; Longitud del string
    mov     ecx, dword [ebp + 4 * ebx]
    call    DisplayNorm                     ; Mostrar texto de manera normal
    pop     edi                             ; mover longitud al EDI
    mov     esi, dword [ebp + 4 * ebx]
    inc     ebx                             ; Se aumenta la posición del arreglo de argumentos
    jmp     DoNextArg

NoArgs:
   ; No args entered,   
   ; start program without args here
    mov eax,sys_write      ; call system 'write' id 4 
    mov ebx,stdout         ; descriptor de archivo 1 = pantalla 
    mov ecx,noArgus        ; guardo la cadena en un registro ecx 
    mov edx,noArgusLong    ; guardo la cadena en un registro edx 
    int 80h                ; interrupcion para invocar al kernel           
    jmp Exit               ; Salida del programa 

DisplayNorm:
    
    push    ebx ;Esto me imprime el argumento que ingreso
    mov     eax, sys_write
    mov     ebx, stdout
    int     80H 
    mov     ecx, szLineFeed ;Esto imprime \n
    mov     edx, 1
    mov     eax, sys_write
    mov     ebx, stdout
    int     80H
    pop     ebx
    ret

; StrsNotEqual:
;     mov eax,sys_write      ; call system 'write' id 4 
;     mov ebx,stdout         ; descriptor de archivo 1 = pantalla 
;     mov ecx,mensaje   ; guardo la cadena en un registro ecx 
;     mov edx,mensajel   ; guardo longitud de la cadena en un registro edx 
;     int 80h                 ; interrupcion para invocar al kernel 
;     jmp Exit

GetStrlen: ;me devuelve la longitud del argumento
    push    ebx
    xor     ecx, ecx
    not     ecx
    xor     eax, eax
    cld
    repne   scasb
    mov     byte [edi - 1], 10
    not     ecx
    pop     ebx
    lea     edx, [ecx - 1]
    ret

; TooManyArgs: ;Bloque de codigo si quiero limitar argumentos
;     mov     eax, sys_write
;     mov     ebx, stdout
;     mov     ecx, szErrMsg
;     mov     edx, ERRLEN
;     int     80H

; EsArgE:
;     mov eax,sys_write      ; call system 'write' id 4 
;     mov ebx,stdout         ; descriptor de archivo 1 = pantalla 
;     mov ecx,mensaje   ; guardo la cadena en un registro ecx 
;     mov edx,mensajel   ; guardo la cadena en un registro edx 
;     int 80h                 ; interrupcion para invocar al kernel 
;     jmp Exit

Exit: ;Salida del programa
    mov     esp, ebp
    pop     ebp
    mov     eax, sys_exit
    xor     ebx, ebx
    int     80H