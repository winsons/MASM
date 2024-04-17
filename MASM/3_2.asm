.586
.MODEL flat, stdcall
INCLUDELIB kernel32.lib
INCLUDELIB msvcrt.lib
ExitProcess PROTO, dwExitCode:DWORD
printf PROTO C, :PTR BYTE, :VARARG
scanf PROTO C, :PTR BYTE, :VARARG

.data
inputFormat db "%s", 0
outputFormat db "flag= %c", 13, 10, 0
HWword db 100 dup(0)            ; 数组，存储字符串，最多可能有100个字符
n dd 0                 ; 存储字符的数量
left dd 0
right dd 0
flag dd 'Y'

.code
main PROC
Scanf1:
    lea     eax,[HWword]  
    push    eax  
    push    offset inputFormat
    call    scanf  
    add     esp,8
J1:
    cmp n,100
    jge Print1
    mov eax,n
    movsx ecx,HWword[eax]
    cmp ecx,0
    je X
    inc n
    jmp J1
X:
    mov eax,n
    mov right,eax
    jmp J2
X1:
    inc left
    
J2:
    dec right
    mov eax,left
    cmp eax,right
    jge Print1
    ;mov eax,left
    movsx ecx,HWword[eax]
    mov ebx,right
    movsx edx,HWword[ebx]
    cmp ecx,edx
    je X1
    mov flag,'N'
Print1:
    push flag
    push offset outputFormat
    call printf
    exit_program:
        invoke ExitProcess, 0        ; 退出程序

main ENDP
end main
