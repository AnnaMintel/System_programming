.686
.model flat, stdcall
include macroses.inc

.data
include vars.inc

.code
include procedures.inc

WinMain PROC

    INIT_CONSOLE

	WRITE '������� ������ �����: '
	INVOKE READNUMBER
	mov ebx, eax
	
	WRITE '������� ������ �����: '
	INVOKE READNUMBER
	add eax, ebx
	
	WRITE '����� = '
	WRITE_NUMBER eax
	
    READLN_CONSOLE
    INVOKE ExitProcess, 0

WinMain ENDP
end WinMain