.586
.MODEL flat, stdcall
INCLUDELIB kernel32.lib
INCLUDELIB msvcrt.lib

; �ⲿ��������
ExitProcess PROTO, dwExitCode:DWORD
printf PROTO C, :PTR BYTE, :VARARG

.data
outputFormat db "sum = %d,n=%d", 13, 10, 0  ; printf�ĸ�ʽ�ַ���
sum dd 0                              ; �洢������ַ�
n dd 1                             ; �洢����ı�־

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

	; �˳�����
    invoke ExitProcess, 0
main3 ENDP
end main3
