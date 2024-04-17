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
currentNumber dd 10                 ; ��ǰ�������֣���ʼֵΪ 10

.CODE
main PROC
    ; ��ʼ��������
    mov [count], 0
    ; ��ʼ�� currentNumber Ϊ 10
    mov [currentNumber], 10

checkLoop:
    cmp [currentNumber], 10000       ; ����Ƿ񵽴� 10000
    jg endLoop                       ; ��������������ѭ��
    mov ecx, [currentNumber]         ; �� currentNumber ��ֵ�� ecx
    call IsPalindrome                ; ��鵱ǰ�����Ƿ��ǻ�����
    cmp eax, 0                       ; ��� IsPalindrome ����ֵ�Ƿ�Ϊ 1�����ģ�
    je nextNumber                    ; ������ǻ��ģ�������һ������
    ; ����ǻ��ģ�
    inc dword ptr [count]            ; ���ļ������� 1
    push currentNumber
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
    inc dword ptr [currentNumber]    ; ���� currentNumber
    jmp checkLoop
endLoop:
    invoke ExitProcess, 0            ; �����˳�����

IsPalindrome PROC
    mov eax, [currentNumber]         ; �ӱ����л�ȡ��ǰ����
    mov ebx, 0                       ; ������ת���ִ洢
reverseLoop:
    xor edx, edx                     ; ���� edx
    mov ecx, 10                      ; ���ó���Ϊ 10
    div ecx                          ; eax ���� 10����������� eax �У������� edx ��
    add ebx, edx                     ; �������ӵ���ת����
    cmp eax, 0
    je checkPalindrome               ; �����Ϊ 0������Ƿ����
    imul ebx, 10                     ; ����ת���ֳ��� 10
    jmp reverseLoop
checkPalindrome:
    mov eax, [currentNumber]         ; �ٴλ�ȡԭʼ����
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
