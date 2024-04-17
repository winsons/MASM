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
currentNumber dd 10                 ; 当前检查的数字，初始值为 10

.CODE
main PROC
    ; 初始化计数器
    mov [count], 0
    ; 初始化 currentNumber 为 10
    mov [currentNumber], 10

checkLoop:
    cmp [currentNumber], 10000       ; 检查是否到达 10000
    jg endLoop                       ; 如果超过，则结束循环
    mov ecx, [currentNumber]         ; 将 currentNumber 赋值给 ecx
    call IsPalindrome                ; 检查当前数字是否是回文数
    cmp eax, 0                       ; 检查 IsPalindrome 返回值是否为 1（回文）
    je nextNumber                    ; 如果不是回文，继续下一个数字
    ; 如果是回文：
    inc dword ptr [count]            ; 回文计数器加 1
    push currentNumber
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
    inc dword ptr [currentNumber]    ; 递增 currentNumber
    jmp checkLoop
endLoop:
    invoke ExitProcess, 0            ; 调用退出过程

IsPalindrome PROC
    mov eax, [currentNumber]         ; 从变量中获取当前数字
    mov ebx, 0                       ; 重置逆转数字存储
reverseLoop:
    xor edx, edx                     ; 清零 edx
    mov ecx, 10                      ; 设置除数为 10
    div ecx                          ; eax 除以 10，结果的商在 eax 中，余数在 edx 中
    add ebx, edx                     ; 将余数加到逆转数字
    cmp eax, 0
    je checkPalindrome               ; 如果商为 0，检查是否回文
    imul ebx, 10                     ; 将逆转数字乘以 10
    jmp reverseLoop
checkPalindrome:
    mov eax, [currentNumber]         ; 再次获取原始数字
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
