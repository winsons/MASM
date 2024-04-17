.586
.MODEL flat, stdcall
INCLUDELIB kernel32.lib
INCLUDELIB msvcrt.lib
ExitProcess PROTO, dwExitCode:DWORD
printf PROTO C, :PTR BYTE, :VARARG
scanf PROTO C, :PTR BYTE, :VARARG

.data
inputFormat db "%[^\n]", 0
outputFormat db "space=%d,low=%d", 13, 10, 0
;msg db 100 dup(0)            ; 数组，存储字符串，最多可能有100个字符
msg db "I have an apple"
space dd 0
n dd 0                 ; 存储字符的数量
lowercase dd 0

.code
main PROC
Scanf1:
   ;incorrect scanf for string with space(20h)!!!
   ;lea ebx,[msg]
   ;push ebx
   ;push offset inputFormat
   ;call scanf
   ;add esp,8h

J1:   
   mov eax,n
   cmp msg[eax],0h
   je Print1
   inc n
   cmp msg[eax],20h
   jne Next1
   inc space
   jmp J1
Next1:
   cmp msg[eax],61h
   jge lz
   jmp J1
lz:
   cmp msg[eax],'z'
   jg  J1
   inc lowercase
   jmp J1
Print1:
   push lowercase
   push space
   push offset outputFormat
   call printf
   
    exit_program:
        invoke ExitProcess, 0        ; 退出程序

main ENDP
end main
