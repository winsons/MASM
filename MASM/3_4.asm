.586
.MODEL flat, stdcall
INCLUDELIB kernel32.lib
INCLUDELIB msvcrt.lib
ExitProcess PROTO, dwExitCode:DWORD
printf PROTO C, :PTR BYTE, :VARARG

.data
outputFormat db "max=%d,low=%d", 13, 10, 0
;msg db 100 dup(0)            ; 数组，存储字符串，最多可能有100个字符
array sdword 12,4,168,122,-33,56,78,99,345,66,-5
max sdword 0
min sdword 0                 
i dd 1

.code
main PROC
    mov eax,0
    mov ebx,array[eax]
    mov max,ebx
    mov ecx,array[eax]
    mov min,ecx

loop_Start:
    cmp i,11
    je Print1
    mov ebx,i
    inc i
    mov ecx,array[ebx*4]
    cmp max,ecx
    jg JS1
    mov max,ecx
    jmp loop_Start
JS1:
    mov ecx,array[ebx*4]
    cmp min,ecx
    jb loop_Start
    mov min,ecx
    jmp loop_Start
    
Print1:
   push min
   push max
   push offset outputFormat
   call printf
   
    exit_program:
        invoke ExitProcess, 0        ; 退出程序

main ENDP
end main
