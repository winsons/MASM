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

main ENDP
END main
