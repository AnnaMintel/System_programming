; ��������� ���������� ������������ ����� ��������
.686
.model flat, stdcall
include macroses.inc
include math.txt


.data
include vars.inc


n EQU 5			; ������ ��������� n ������ 5
a DD n DUP(?)	; ������ ������ "�" �� n ���������, ������ ������� ������ 32 ���� (DD), ����������������� (?)
b DD n DUP(?)	; ������ ������ "b" �� n ���������, ������ ������� ������ 32 ���� (DD), ����������������� (?)
d DD n DUP(?)	; ������ ������ "d" �� n ���������, ������ ������� ������ 32 ���� (DD), ����������������� (?)

promt1 DB 'vvedite elementy massiva A',13,10 ; ������ ��������� ���������� ��� ������ �� �����
promt2 DB 'vvedite elementy massiva B',13,10
promt3 DB 'vvedite elementy massiva C',13,10
promt4 DB 'vvod zavershen',13,10


.code
include procedures.inc

WinMain PROC

	INIT_CONSOLE

	;
	; Input A
	;

	WRITE_STRING promt1 ; ����� �� ����� ��������� promt1 - ������ �������� ������� "�"
	VVOD_MASSIVE a

	;
	; Input B	;
	; �� ����� �� ����� ��������� ���� ������� �

	WRITE_STRING promt2
	VVOD_MASSIVE b
	
	;
	; Input d	;
	; �� ����� �� ����� ��������� ���� ������� d

  	WRITE_STRING promt3
	VVOD_MASSIVE d

	WRITE_STRING promt4
	
	READLN_CONSOLE
	INVOKE READNUMBER
	INVOKE ExitProcess, 0

WinMain ENDP
end WinMain