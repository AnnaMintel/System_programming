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
	WRITELN ' '
	cmp eax, var1

	jns bolshe
	mov eax, var1

WRITELN 'Var1 больше'
	mov  var2, eax

	jmp exit ; перепрыгиваем на завершение программы
	
bolshe: WRITE '–езультат = '
WRITE_NUMBER eax, var2
	
    exit: READLN_CONSOLE
    INVOKE ExitProcess, 0

WinMain ENDP
end WinMain