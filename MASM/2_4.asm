.586
.MODEL flat, stdcall
INCLUDELIB kernel32.lib
INCLUDELIB msvcrt.lib

; 外部函数声明
ExitProcess PROTO, dwExitCode:DWORD
printf PROTO C, :PTR BYTE, :VARARG

.data
outputFormat db "sum = %d,n=%d", 13, 10, 0  ; printf的格式字符串
sum dd 0                              ; 存储输入的字符
n dd 1                             ; 存储输出的标志

.code
main3 PROC
J1:
	cmp	n,100
	jg Print1
	mov eax,sum
	add eax,n
	mov sum,eax
	inc n
	jmp J1

Print1:
	dec n
	push n 
	push sum
	push offset outputFormat
	call printf

	; 退出程序
    invoke ExitProcess, 0
main3 ENDP
end main3
