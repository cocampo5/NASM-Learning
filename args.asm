MAXARGS     equ     5 ; 1 = program path 2 = 1st arg  3 = 2nd arg etc...
sys_exit    equ     1
sys_read    equ     3
sys_write   equ     4
stdin       equ     0
stdout      equ     1
stderr      equ     3

SECTION     .data

;szErrMsg    db      "Too many arguments.  The max number of args is 4", 10
;ERRLEN      equ     $-szErrMsg
szLineFeed  db      10

SECTION     .text

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
    jz      Exit
    call    GetStrlen
    push    edx                             ; save string length for reverse
    mov     ecx, dword [ebp + 4 * ebx]
    call    DisplayNorm                     ; display arg text normally
    pop     edi                             ; move string length into edi
    mov     esi, dword [ebp + 4 * ebx]
    call    ReverseIt                       ; now display in reverse
    inc     ebx                             ; step arg array index
    jmp     DoNextArg
ReverseIt:
    push    ebx
    add     esi, edi
Next:
    mov     eax, sys_write
    mov     ebx, stdout
    mov     ecx, esi
    mov     edx, 1
    int     80H   
    dec     esi
    dec     edi
    jns     Next
    mov     ecx, szLineFeed
    mov     edx, 1
    mov     eax, sys_write
    mov     ebx, stdout
    int     80H

    pop     ebx

    ret
NoArgs:
   ; No args entered,
   ; start program without args here
    jmp     Exit
DisplayNorm:
    push    ebx
    mov     eax, sys_write
    mov     ebx, stdout
    int     80H 
    pop     ebx
    ret
GetStrlen:
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
; TooManyArgs:
;     mov     eax, sys_write
;     mov     ebx, stdout
;     mov     ecx, szErrMsg
;     mov     edx, ERRLEN
;     int     80H

Exit:
    mov     esp, ebp
    pop     ebp
    mov     eax, sys_exit
    xor     ebx, ebx
    int     80H
