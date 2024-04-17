COMMENT !
.586
.MODEL flat, stdcall
INCLUDELIB kernel32.lib
INCLUDELIB msvcrt.lib

; �ⲿ��������
ExitProcess PROTO, dwExitCode:DWORD
scanf PROTO C, :PTR BYTE, :VARARG
printf PROTO C, :PTR BYTE, :VARARG
toupper PROTO C, :DWORD         ; ����toupper������ע�������������

.data
inputFormatChar db "%c", 0           ; scanf�ĸ�ʽ�ַ����������ַ�����
outputFormat db "Character: %c, caps = %d", 13, 10, 0  ; printf�ĸ�ʽ�ַ���
ch1 dw ?                              ; �洢������ַ�
caps dw ?                             ; �洢����ı�־

.code
main2 PROC
    ; �����ַ�
    lea eax, ch1
    push eax
    push offset inputFormatChar
    call scanf
    add esp, 8

    ; ����Ƿ�ΪСд��ĸ
    movzx eax, ch1                    ; ���ַ����ص�eax����չΪ32λ
    cmp eax, 'a'
    jl NOT_LOWERCASE
    cmp eax, 'z'
    jg NOT_LOWERCASE

    ; ��Сд��ĸ��ת��Ϊ��д
    push eax
    call toupper
    add esp, 4
    mov ch1, ax
    mov caps, 0

NOT_LOWERCASE:
    ; ����Ƿ�Ϊ��д��ĸ
    movzx eax, ch1                    ; ���¼����ַ���eax
    cmp eax, 'A'
    jl NOT_UPPERCASE
    cmp eax, 'Z'
    jg NOT_UPPERCASE

    ; �Ǵ�д��ĸ
    mov caps, 1

NOT_UPPERCASE:
    ; ������
    push dword ptr caps
    push dword ptr ch1
    push offset outputFormat
    call printf
    add esp, 12

    ; �˳�����
    invoke ExitProcess, 0

main2 ENDP
end main2
!
end