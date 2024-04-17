.586
.MODEL flat, stdcall
INCLUDELIB kernel32.lib
INCLUDELIB msvcrt.lib
ExitProcess PROTO, dwExitCode:DWORD
printf PROTO C, :PTR BYTE, :VARARG

.data
outputFormat db "%s", 13, 10, 0
string db 'i have an apple,I have an banana',0
string1 db 50 dup(0)
i dd 0
j dd 0

.code
main PROC
J1:
    mov eax,i
    inc i
    movsx ebx,string[eax]
    cmp ebx,0
    je Print
    cmp ebx,20h
    je J1
    mov ecx,j
    mov dl,string[eax]
    mov string1[ecx],dl
    inc j
    jmp J1
Print:
    push offset string1
    push offset outputFormat
    call printf
exit_program:
    invoke ExitProcess, 0   ; Exit the program

main ENDP
end main