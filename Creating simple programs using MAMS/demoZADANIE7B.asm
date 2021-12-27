.686
.model flat, stdcall
include macroses.inc

.data
include vars.inc
var1 DD 0
var2 DD 0

.code
include procedures.inc

WinMain PROC

    INIT_CONSOLE

	WRITE '¬ведите первое число: '
	INVOKE READNUMBER
	mov var1, eax
	
	WRITE '¬ведите второе число: '
	INVOKE READNUMBER
	mov var2, eax
	
	mov eax, var1
	add eax, var2

	WRITE '—умма = '
	WRITE_NUMBER eax
	
    READLN_CONSOLE
    INVOKE ExitProcess, 0

WinMain ENDP
end WinMain