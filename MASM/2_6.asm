.586
.MODEL flat, stdcall
INCLUDELIB kernel32.lib
INCLUDELIB msvcrt.lib

; �ⲿ��������
ExitProcess PROTO, dwExitCode:DWORD
printf PROTO C, :PTR BYTE, :VARARG
scanf PROTO C, :PTR BYTE, :VARARG

.data
inputFormatChar db "%d", 0           ; scanf�ĸ�ʽ�ַ����������ַ�����
outputFormat1 db "is leap year", 13, 10, 0  ; printf�ĸ�ʽ�ַ���
outputFormat2 db "is not leap year", 13, 10, 0  ; printf�ĸ�ʽ�ַ���
year dd ?

.code
main3 PROC
;����
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
	; �˳�����
    invoke ExitProcess, 0
Print2:
	push offset outputFormat1
	call printf
	; �˳�����
    invoke ExitProcess, 0
main3 ENDP
end main3
