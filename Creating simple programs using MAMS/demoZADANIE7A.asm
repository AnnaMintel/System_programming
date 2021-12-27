.686
.model flat, stdcall
include macroses.inc

.data
include vars.inc

.code
include procedures.inc

WinMain PROC

    INIT_CONSOLE

	WRITE 'Будет выведена сумма чисел от 5 до 7 : '
	
	xor eax, eax;
	add eax, 5
	add eax, 6
	add eax, 7 

	WRITE 'Сумма = '
	WRITE_NUMBER eax
	
    READLN_CONSOLE
    INVOKE ExitProcess, 0

WinMain ENDP
end WinMain