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

	WRITE 'Введите первое число: '
	INVOKE READNUMBER
	mov var1, eax
	
	WRITE 'Введите второе число: '
	INVOKE READNUMBER
	WRITELN ' '
	sub eax, var1 ; разность

	jns bolshe_0
	mov eax, var1

WRITELN 'Число меньше или равно 0 '
	mov eax, 0
WRITE 'В регистре EAX находится: '
WRITE_NUMBER eax
	jmp exit ; перепрыгиваем на завершение программы
	
bolshe_0: WRITE 'Разность Второе минус Первое = '
WRITE_NUMBER eax
	
    exit: READLN_CONSOLE
    INVOKE ExitProcess, 0

WinMain ENDP
end WinMain