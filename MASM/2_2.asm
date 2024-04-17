COMMENT !
.586
.MODEL flat, stdcall
INCLUDELIB kernel32.lib
INCLUDELIB msvcrt.lib

; 外部函数声明
ExitProcess PROTO, dwExitCode:DWORD
scanf PROTO C, :PTR BYTE, :VARARG
printf PROTO C, :PTR BYTE, :VARARG
toupper PROTO C, :DWORD         ; 声明toupper函数，注意调整参数类型

.data
inputFormatChar db "%c", 0           ; scanf的格式字符串，用于字符输入
outputFormat db "Character: %c, caps = %d", 13, 10, 0  ; printf的格式字符串
ch1 dw ?                              ; 存储输入的字符
caps dw ?                             ; 存储输出的标志

.code
main2 PROC
    ; 输入字符
    lea eax, ch1
    push eax
    push offset inputFormatChar
    call scanf
    add esp, 8

    ; 检查是否为小写字母
    movzx eax, ch1                    ; 将字符加载到eax，扩展为32位
    cmp eax, 'a'
    jl NOT_LOWERCASE
    cmp eax, 'z'
    jg NOT_LOWERCASE

    ; 是小写字母，转换为大写
    push eax
    call toupper
    add esp, 4
    mov ch1, ax
    mov caps, 0

NOT_LOWERCASE:
    ; 检查是否为大写字母
    movzx eax, ch1                    ; 重新加载字符到eax
    cmp eax, 'A'
    jl NOT_UPPERCASE
    cmp eax, 'Z'
    jg NOT_UPPERCASE

    ; 是大写字母
    mov caps, 1

NOT_UPPERCASE:
    ; 输出结果
    push dword ptr caps
    push dword ptr ch1
    push offset outputFormat
    call printf
    add esp, 12

    ; 退出程序
    invoke ExitProcess, 0

main2 ENDP
end main2
!
end