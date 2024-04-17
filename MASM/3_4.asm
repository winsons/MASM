.586
.MODEL flat, stdcall
INCLUDELIB kernel32.lib
INCLUDELIB msvcrt.lib
ExitProcess PROTO, dwExitCode:DWORD
printf PROTO C, :PTR BYTE, :VARARG

.data
outputFormat db "max=%d, low=%d", 13, 10, 0
array dd 12,4,168,122,-33,56,78,99,345,66,-5
max dd 0
min dd 0
i dd 0

.code
main PROC
    mov eax, 0
    mov ebx, [array+eax*4]  ; Load first element of the array
    mov max, ebx            ; Set as initial max
    mov min, ebx            ; Set as initial min

loop_Start:
    inc i                   ; Increment index before comparison
    cmp i, 11               ; Compare index with array length
    jge Print               ; Jump to print if index is 11 or greater

    mov eax, i
    mov ebx, [array+eax*4]  ; Load current element
    cmp max, ebx
    jg  Check_Min           ; Go to check min if current is not greater than max
    mov max, ebx            ; Set new max

Check_Min:
    cmp min, ebx
    jl  loop_Start          ; Continue loop if current is not less than min
    mov min, ebx            ; Set new min
    jmp loop_Start          ; Continue loop

Print:
    push min                ; Push min to be printed first (stack order)
    push max                ; Push max
    push offset outputFormat
    call printf
    add esp, 12             ; Clean up the stack

exit_program:
    invoke ExitProcess, 0   ; Exit the program

main ENDP
end main
