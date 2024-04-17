.586
.MODEL flat, stdcall
INCLUDELIB kernel32.lib
INCLUDELIB msvcrt.lib
ExitProcess PROTO, dwExitCode:DWORD
printf PROTO C, :PTR BYTE, :VARARG

.data
outputFormat db "Leap year: %d", 13, 10, 0
Lyear dd 88 dup(0)            ; 数组，存储闰年，最多可能有88个闰年
Lcounter dd 0                 ; 存储闰年的数量

.code
main PROC
    mov ecx, 2012             ; 设置起始年份为2012
    mov esi, 0                ; 闰年计数器esi初始化为0

    ; 进入循环，检查每一年是否为闰年
    while_loop:
        cmp ecx, 2100         ; 比较年份是否达到2100
        jge end_while         ; 如果年份大于等于2100，则结束循环

        ; 检查是否为闰年
        mov eax, ecx
        mov ebx, 4
        cdq
        div ebx               ; eax / 4
        cmp edx, 0            ; 如果 % 4 == 0
        jne increment_year    ; 如果不等于0，跳过

        mov eax, ecx
        mov ebx, 100
        cdq
        div ebx               ; eax / 100
        cmp edx, 0            ; 如果 % 100 == 0
        je check_400          ; 如果等于0，检查 % 400

        jmp is_leap_year      ; 如果不是整百年份，是闰年

        check_400:            ; 对整百年份检查400
            mov eax, ecx
            mov ebx, 400
            cdq
            div ebx           ; eax / 400
            cmp edx, 0
            jne increment_year ; 如果不是 % 400 == 0，不是闰年

        is_leap_year:
            mov eax, ecx
            mov [Lyear + esi*4], eax ; 将年份存储在数组中
            inc esi                   ; 闰年计数器加1

        increment_year:
            inc ecx                   ; 年份加1
            jmp while_loop            ; 继续循环

    end_while:
        mov [Lcounter], esi           ; 存储闰年总数

    ; 输出闰年
    print_leap_years:
        xor esi, esi                 ; 重置esi为0
        mov ebx, [Lcounter]          ; 获取闰年个数
        test ebx, ebx                ; 检查是否有闰年
        jz exit_program              ; 如果没有闰年，退出程序

        printing_loop:
            cmp esi, ebx             ; 检查是否已全部打印
            jge exit_program         ; 如果已全部打印，退出程序

            push [Lyear + esi*4]     ; 将闰年推到堆栈
            push offset outputFormat ; 将格式字符串推到堆栈
            call printf              ; 调用printf打印年份
            add esp, 8               ; 清理堆栈

            inc esi                  ; esi加1
            jmp printing_loop        ; 继续打印

    exit_program:
        invoke ExitProcess, 0        ; 退出程序

main ENDP
end main
