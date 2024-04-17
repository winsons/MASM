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

main ENDP
END main
