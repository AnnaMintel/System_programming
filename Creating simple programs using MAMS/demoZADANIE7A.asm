.686
.model flat, stdcall
include macroses.inc

.data
include vars.inc

.code
include procedures.inc

WinMain PROC

    INIT_CONSOLE

	WRITE '����� �������� ����� ����� �� 5 �� 7 : '
	
	xor eax, eax;
	add eax, 5
	add eax, 6
	add eax, 7 

	WRITE '����� = '
	WRITE_NUMBER eax
	
    READLN_CONSOLE
    INVOKE ExitProcess, 0

WinMain ENDP
end WinMain