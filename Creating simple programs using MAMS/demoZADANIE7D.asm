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

	WRITE '������� ������ �����: '
	INVOKE READNUMBER
	mov var1, eax
	
	WRITE '������� ������ �����: '
	INVOKE READNUMBER
	WRITELN ' '
	cmp eax, var1

	jns bolshe
	mov eax, var1

WRITELN 'Var1 ������'
	mov  var2, eax

	jmp exit ; ������������� �� ���������� ���������
	
bolshe: WRITE '��������� = '
WRITE_NUMBER eax, var2
	
    exit: READLN_CONSOLE
    INVOKE ExitProcess, 0

WinMain ENDP
end WinMain