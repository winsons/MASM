.586
.MODEL flat, stdcall
INCLUDELIB kernel32.lib
INCLUDELIB msvcrt.lib

; �ⲿ��������
ExitProcess PROTO, dwExitCode:DWORD
printf PROTO C, :PTR BYTE, :VARARG

.data
inputFormatChar db "%d", 0           ; scanf�ĸ�ʽ�ַ����������ַ�����
outputFormat db "sum = %d", 13, 10, 0  ; printf�ĸ�ʽ�ַ���
sum dd 0                              ; �洢������ַ�
i dd 1                             ; �洢����ı�־

.code
main3 PROC

J1:
	cmp i,101
	jb J2
	jg Print1
J2:
	mov edx,0
	mov eax,i
	mov ebx,2
	div ebx
	cmp edx,0
	je J3
	inc i
	jmp J1
J3:
	mov eax,sum
	add eax,i
	mov sum,eax
	inc i
	jmp J1
Print1:
	push sum
	push offset outputFormat
	call printf

	; �˳�����
    invoke ExitProcess, 0
main3 ENDP
end main3
