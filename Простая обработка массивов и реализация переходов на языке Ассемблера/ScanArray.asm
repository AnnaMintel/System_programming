.686
.model flat, stdcall
include	macroses.inc

.data
include vars.inc
mas DB 8, 5, 0, 6, 0, 0, 6, 0, 9, -8, 0, 0, 0, 9, 15, 0, 4, -45, -3, 0   ;������ ������ ����� ����� 

.code
include procedures.inc

WinMain PROC
	
	INIT_CONSOLE
	WRITE '���������� ��������� ��������� ������� = '

	lea esi, mas	; ��������� � ������� ESI ��������� ����� ������� 
	mov ecx, SIZEOF mas	; ���������� ����������� ������� � ������� �� � ������� E�X
	xor edx, edx		; ��������� �������� EDX - ���������� ��� �������� "�������"

start:
	mov al, [esi] ; �������� ������� ����� �������� �������, �������������� �� ������ � �������� ESI- � ������� AL
	inc esi       ; ����������� ����� ���������� �������� �������
	cmp al, 0			; ��������� � �����
	je skip		; ������� ���� ����� (����) - ����� ���������� EDX
	inc edx		; ���������� �������� ��������� ���� CMP ��� �� ����		
skip:
	loop start			; ���� ECX ������ ���� - �� ��������� ������� �������, 
						; �� ��������� �� ����� start � ��������� ECX �� 1, ���� ECX=0 - ��������� �������
	WRITE_NUMBER edx	; ����� �� ����� ���������� ������� � �������
	
	READLN_CONSOLE
    INVOKE ExitProcess, 0
WinMain ENDP

end WinMain