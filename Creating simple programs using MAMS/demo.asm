.686
.model flat, stdcall
include macroses.inc

.data
include vars.inc

.code
include procedures.inc

WinMain PROC

    INIT_CONSOLE

	WRITE '¬ведите первое число: '
	INVOKE READNUMBER
	mov ebx, eax
	
	WRITE '¬ведите второе число: '
	INVOKE READNUMBER
	add eax, ebx
	
	WRITE '—умма = '
	WRITE_NUMBER eax
	
    READLN_CONSOLE
    INVOKE ExitProcess, 0

WinMain ENDP
end WinMain