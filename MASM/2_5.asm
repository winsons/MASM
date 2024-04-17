.586
.MODEL flat, stdcall
INCLUDELIB kernel32.lib
INCLUDELIB msvcrt.lib

; 外部函数声明
ExitProcess PROTO, dwExitCode:DWORD
printf PROTO C, :PTR BYTE, :VARARG
scanf PROTO C, :PTR BYTE, :VARARG

.data
inputFormatChar db "%d %d %d", 0           ; scanf的格式字符串，用于字符输入
outputFormat db "a = %d,b=%d,c=%d", 13, 10, 0  ; printf的格式字符串
a dd ?
b dd ?
intc dd ?

.code
main3 PROC
;输入
	push offset intc
	push offset b
	push offset a
	push offset inputFormatChar
	call scanf

	add esp,8

	mov eax,a
	cmp eax,b
	jg J1
	xchg eax,b
	mov a,eax

J1:
	mov eax,a	
	cmp eax,intc
	jg J2
	xchg eax,intc
	mov a,eax

J2:
	mov eax,b
	cmp eax,intc
	jg Print1
	xchg eax,intc
	mov b,eax
Print1:
	push a
	push b
	push intc
	push offset outputFormat
	call printf

	; 退出程序
    invoke ExitProcess, 0
main3 ENDP
end main3
