.MODEL flat, stdcall
INCLUDELIB kernel32.lib
INCLUDELIB msvcrt.lib
ExitProcess PROTO, dwExitCode:DWORD
printf PROTO C, :PTR BYTE, :VARARG

.DATA
outputFormat db "%d ", 0             ; 输出格式字符串，用于 printf
newLine db 10, 0                     ; 新行字符（换行）
count dd 0                           ; 已打印数字的计数器
maxPerLine dd 10                     ; 每行最大数字数量
ten dd 10                            ; 常数 10

.CODE
main PROC
    mov ecx, 10                      ; 从数字 10 开始
checkLoop:
    cmp ecx, 10000                   ; 检查是否到达 10000
    jg endLoop                       ; 如果超过，则结束循环
    push ecx                         ; 保存当前数字，稍后使用
    call IsPalindrome                ; 检查当前数字是否是回文数
    pop ecx                          ; 恢复当前数字
    cmp eax, 0                       ; 检查 IsPalindrome 返回值是否为 1（回文）
    je nextNumber                    ; 如果不是回文，继续下一个数字
    ; 如果是回文：
    inc dword ptr [count]            ; 回文计数器加 1
    push ecx
    push offset outputFormat
    call printf                      ; 打印数字
    add esp, 8                       ; 清理堆栈（两个参数）
    ; 检查是否需要换行：
    mov eax, [count]
    cmp eax, [maxPerLine]
    jl nextNumber                    ; 如果小于最大行数，继续循环
    ; 打印新行并重置计数器：
    push offset newLine
    call printf
    add esp, 4
    mov dword ptr [count], 0
nextNumber:
    inc ecx                          ; 数字增加
    jmp checkLoop
endLoop:
    push count                       ; 推送最后一个计数值
    push offset outputFormat
    call printf                      ; 打印最后的计数
    invoke ExitProcess, 0            ; 调用退出过程

IsPalindrome PROC
    mov eax, [esp+4]                 ; 从堆栈中获取数字
    mov ebx, 0                       ; 重置逆转数字存储
reverseLoop:
    mov edx, 0
    div dword ptr ten                ; 数字除以 10
    mov edx, eax                     ; 保存商到 edx
    sub eax, edx                     ; 计算余数
    add ebx, eax                     ; 将余数加到逆转数字
    cmp edx, 0
    je checkPalindrome               ; 如果数字归零，检查是否回文
    mov eax, edx                     ; 恢复商到 eax 用于下一次迭代
    ; 将逆转数字乘以 10
    mov edx, 10                      ; 将 10 放入 edx
    imul ebx, edx                    ; ebx = ebx * 10
    jmp reverseLoop
checkPalindrome:
    mov eax, [esp+4]                 ; 再次获取原始数字
    cmp eax, ebx                     ; 比较原始数字和逆转数字
    je isPalindrome1                 ; 如果相等，是回文
    mov eax, 0                       ; 不是回文
    ret
isPalindrome1:
    mov eax, 1                       ; 是回文
    ret
IsPalindrome ENDP
main ENDP
END main
