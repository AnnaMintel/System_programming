.686
.model flat, stdcall
include	macroses.inc

.data
include vars.inc

n EQU 20 
mas DD n DUP(?)
razmer DD 0

.code
include procedures.inc

WinMain PROC
	
	INIT_CONSOLE
	WRITE '������� ������ ������� (�� 2 �� 20) - '
	INVOKE READNUMBER
	mov razmer, eax

	WRITELN  '������� �������� ������� : '
	mov ecx, razmer
	mov ebx, OFFSET mas
input1:
	INVOKE READNUMBER
	mov [ebx], eax
	add ebx, 4
	loop input1

	lea esi, mas	; ��������� � ������� ESI ��������� ����� ������� 
	mov ecx, SIZEOF mas	; ���������� ����������� ������� � ������� �� � ������� E�X
	xor edx, edx		; ��������� �������� EDX - ���������� ��� �������� "�������"

start:
	mov al, [esi] ; �������� ������� ����� �������� �������, �������������� �� ������ � �������� ESI- � ������� AL
	inc esi       ; ����������� ����� ���������� �������� �������
	cmp al, 5			; ��������� � �����
	jle skip		; ������� ���� ����� (����) - ����� ���������� EDX
	inc edx		; ���������� �������� ��������� ���� CMP ��� �� ����		
skip:
	loop start			; ���� ECX ������ ���� - �� ��������� ������� �������, 
						; �� ��������� �� ����� start � ��������� ECX �� 1, ���� ECX=0 - ��������� �������
	WRITELN	' '
	WRITE '����� ��������� ������� ������, ��� 5 = '
	WRITE_NUMBER edx
	
	READLN_CONSOLE
    INVOKE ExitProcess, 0
WinMain ENDP

end WinMain