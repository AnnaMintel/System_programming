; ��������� ���������� ������������ ����� ��������
.686
.model flat, stdcall
include macroses.inc

.data
include vars.inc

n EQU 5			; ������ ��������� n ������ 5
a DD n DUP(?)	; ������ ������ "�" �� n ���������, ������ ������� ������ 32 ���� (DD), ����������������� (?)
b DD n DUP(?)	; ������ ������ "b" �� n ���������, ������ ������� ������ 32 ���� (DD), ����������������� (?)
d DD n DUP(?)	; ������ ������ "d" �� n ���������, ������ ������� ������ 32 ���� (DD), ����������������� (?)

promt1 DB 'vvedite elementy massiva A',13,10 ; ������ ��������� ���������� ��� ������ �� �����
promt2 DB 'vvedite elementy massiva B',13,10
promt3 DB 'vvedite elementy massiva C',13,10

VVOD_MASSIVE MACRO name
LOCAL input1
mov ecx, n			; ��������� � ��� ����� n - ����� ��������� �������� ����� 5
	mov ebx, OFFSET name	; ��������� � EBX ��������� ����� ������� "NAME"
input1:
	INVOKE READNUMBER	; ������ ��������� ����� 
	mov [ebx], eax		; � ����� ��� � ������, ����� ������� ������ � EBX
	add ebx, 4			; ����������� �������� ������ � EBX �� 4 (������ ����� ������� �� 4 ����� - 32 ���� (DD)
	loop input1			; �������� ���� �� ��������� ��� �������� (���� ECX �� ������ ������ 0)
ENDM


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
		
	READLN_CONSOLE
	INVOKE READNUMBER
	INVOKE ExitProcess, 0

WinMain ENDP
end WinMain