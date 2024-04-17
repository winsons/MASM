.586
.MODEL flat, stdcall
INCLUDELIB kernel32.lib
INCLUDELIB msvcrt.lib

; 外部函数声明
ExitProcess PROTO, dwExitCode:DWORD
printf PROTO C, :PTR BYTE, :VARARG
scanf PROTO C, :PTR BYTE, :VARARG

.data
inputFormatChar db "%d", 0           ; scanf的格式字符串，用于字符输入
outputFormat1 db "is leap year", 13, 10, 0  ; printf的格式字符串
outputFormat2 db "is not leap year", 13, 10, 0  ; printf的格式字符串
year dd ?

.code
main3 PROC
;输入
	push offset year
	push offset inputFormatChar
	call scanf

	mov edx,0
	mov eax,year
	mov ebx,400
	div ebx
	cmp edx,0
	je Print2

	mov edx,0
	mov eax,year
	mov ebx,4
	div ebx
	cmp edx,0
	jne Print1

	mov edx,0
	mov eax,year
	mov ebx,100
	div ebx
	cmp edx,0
	je Print1
	jmp Print2

Print1:
	push offset outputFormat2
	call printf
	; 退出程序
    invoke ExitProcess, 0
Print2:
	push offset outputFormat1
	call printf
	; 退出程序
    invoke ExitProcess, 0
main3 ENDP
end main3
