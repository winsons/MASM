.586
.MODEL flat, stdcall
INCLUDELIB kernel32.lib
INCLUDELIB msvcrt.lib
ExitProcess PROTO, dwExitCode:DWORD
printf PROTO C, :PTR BYTE, :VARARG

.data
outputFormat db "Leap year: %d", 13, 10, 0
Lyear dd 88 dup(0)            ; ���飬�洢���꣬��������88������
Lcounter dd 0                 ; �洢���������

.code
main PROC
    mov ecx, 2012             ; ������ʼ���Ϊ2012
    mov esi, 0                ; ���������esi��ʼ��Ϊ0

    ; ����ѭ�������ÿһ���Ƿ�Ϊ����
    while_loop:
        cmp ecx, 2100         ; �Ƚ�����Ƿ�ﵽ2100
        jge end_while         ; �����ݴ��ڵ���2100�������ѭ��

        ; ����Ƿ�Ϊ����
        mov eax, ecx
        mov ebx, 4
        cdq
        div ebx               ; eax / 4
        cmp edx, 0            ; ��� % 4 == 0
        jne increment_year    ; ���������0������

        mov eax, ecx
        mov ebx, 100
        cdq
        div ebx               ; eax / 100
        cmp edx, 0            ; ��� % 100 == 0
        je check_400          ; �������0����� % 400

        jmp is_leap_year      ; �������������ݣ�������

        check_400:            ; ��������ݼ��400
            mov eax, ecx
            mov ebx, 400
            cdq
            div ebx           ; eax / 400
            cmp edx, 0
            jne increment_year ; ������� % 400 == 0����������

        is_leap_year:
            mov eax, ecx
            mov [Lyear + esi*4], eax ; ����ݴ洢��������
            inc esi                   ; �����������1

        increment_year:
            inc ecx                   ; ��ݼ�1
            jmp while_loop            ; ����ѭ��

    end_while:
        mov [Lcounter], esi           ; �洢��������

    ; �������
    print_leap_years:
        xor esi, esi                 ; ����esiΪ0
        mov ebx, [Lcounter]          ; ��ȡ�������
        test ebx, ebx                ; ����Ƿ�������
        jz exit_program              ; ���û�����꣬�˳�����

        printing_loop:
            cmp esi, ebx             ; ����Ƿ���ȫ����ӡ
            jge exit_program         ; �����ȫ����ӡ���˳�����

            push [Lyear + esi*4]     ; �������Ƶ���ջ
            push offset outputFormat ; ����ʽ�ַ����Ƶ���ջ
            call printf              ; ����printf��ӡ���
            add esp, 8               ; �����ջ

            inc esi                  ; esi��1
            jmp printing_loop        ; ������ӡ

    exit_program:
        invoke ExitProcess, 0        ; �˳�����

main ENDP
end main
