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
	sub eax, var1 ; ��������

	jns bolshe_0
	mov eax, var1

WRITELN '����� ������ ��� ����� 0 '
	mov eax, 0
WRITE '� �������� EAX ���������: '
WRITE_NUMBER eax
	jmp exit ; ������������� �� ���������� ���������
	
bolshe_0: WRITE '�������� ������ ����� ������ = '
WRITE_NUMBER eax
	
    exit: READLN_CONSOLE
    INVOKE ExitProcess, 0

WinMain ENDP
end WinMain