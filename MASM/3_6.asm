.MODEL flat, stdcall
INCLUDELIB kernel32.lib
INCLUDELIB msvcrt.lib
ExitProcess PROTO, dwExitCode:DWORD
printf PROTO C, :PTR BYTE, :VARARG

.DATA
outputFormat db "%d ", 0             ; �����ʽ�ַ��������� printf
newLine db 10, 0                     ; �����ַ������У�
count dd 0                           ; �Ѵ�ӡ���ֵļ�����
maxPerLine dd 10                     ; ÿ�������������
ten dd 10                            ; ���� 10

.CODE
main PROC
    mov ecx, 10                      ; ������ 10 ��ʼ
checkLoop:
    cmp ecx, 10000                   ; ����Ƿ񵽴� 10000
    jg endLoop                       ; ��������������ѭ��
    push ecx                         ; ���浱ǰ���֣��Ժ�ʹ��
    call IsPalindrome                ; ��鵱ǰ�����Ƿ��ǻ�����
    pop ecx                          ; �ָ���ǰ����
    cmp eax, 0                       ; ��� IsPalindrome ����ֵ�Ƿ�Ϊ 1�����ģ�
    je nextNumber                    ; ������ǻ��ģ�������һ������
    ; ����ǻ��ģ�
    inc dword ptr [count]            ; ���ļ������� 1
    push ecx
    push offset outputFormat
    call printf                      ; ��ӡ����
    add esp, 8                       ; �����ջ������������
    ; ����Ƿ���Ҫ���У�
    mov eax, [count]
    cmp eax, [maxPerLine]
    jl nextNumber                    ; ���С���������������ѭ��
    ; ��ӡ���в����ü�������
    push offset newLine
    call printf
    add esp, 4
    mov dword ptr [count], 0
nextNumber:
    inc ecx                          ; ��������
    jmp checkLoop
endLoop:
    push count                       ; �������һ������ֵ
    push offset outputFormat
    call printf                      ; ��ӡ���ļ���
    invoke ExitProcess, 0            ; �����˳�����

IsPalindrome PROC
    mov eax, [esp+4]                 ; �Ӷ�ջ�л�ȡ����
    mov ebx, 0                       ; ������ת���ִ洢
reverseLoop:
    mov edx, 0
    div dword ptr ten                ; ���ֳ��� 10
    mov edx, eax                     ; �����̵� edx
    sub eax, edx                     ; ��������
    add ebx, eax                     ; �������ӵ���ת����
    cmp edx, 0
    je checkPalindrome               ; ������ֹ��㣬����Ƿ����
    mov eax, edx                     ; �ָ��̵� eax ������һ�ε���
    ; ����ת���ֳ��� 10
    mov edx, 10                      ; �� 10 ���� edx
    imul ebx, edx                    ; ebx = ebx * 10
    jmp reverseLoop
checkPalindrome:
    mov eax, [esp+4]                 ; �ٴλ�ȡԭʼ����
    cmp eax, ebx                     ; �Ƚ�ԭʼ���ֺ���ת����
    je isPalindrome1                 ; �����ȣ��ǻ���
    mov eax, 0                       ; ���ǻ���
    ret
isPalindrome1:
    mov eax, 1                       ; �ǻ���
    ret
IsPalindrome ENDP
main ENDP
END main
