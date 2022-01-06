; ��������� ���������� ������������ ����� ��������
.686
.model flat, stdcall
include macroses.inc

.data
include vars.inc

n EQU 5			; ������ ��������� n ������ 5
a DD n DUP(?)	; ������ ������ "�" �� n ���������, ������ ������� ������ 32 ���� (DD), ����������������� (?)
b DD n DUP(?)	; ������ ������ "b" �� n ���������, ������ ������� ������ 32 ���� (DD), ����������������� (?)

promt1 DB 'vvedite elementy massiva A',13,10 ; ������ ��������� ���������� ��� ������ �� �����
promt2 DB 'vvedite elementy massiva B',13,10
promt3 DB 'Rezyltat',13,10

.code
include procedures.inc

WinMain PROC

	INIT_CONSOLE

	;
	; Input A
	;

	WRITE_STRING promt1 ; ����� �� ����� ��������� promt1 - ������ �������� ������� "�"
	mov ecx, n			; ��������� � ��� ����� n - ����� ��������� �������� ����� 5
	mov ebx, OFFSET a	; ��������� � EBX ��������� ����� ������� "�"
input1:
	INVOKE READNUMBER	; ������ ��������� ����� 
	mov [ebx], eax		; � ����� ��� � ������, ����� ������� ������ � EBX
	add ebx, 4			; ����������� �������� ������ � EBX �� 4 (������ ����� ������� �� 4 ����� - 32 ���� (DD)
	loop input1			; �������� ���� �� ��������� ��� �������� (���� ECX �� ������ ������ 0)

	;
	; Input B	;
	; �� ����� �� ����� ��������� ���� ������� �

	WRITE_STRING promt2
	mov ecx, n
	mov ebx, OFFSET b
input2:
	INVOKE READNUMBER
	mov [ebx], eax
	add ebx, 4
	loop input2
	
	;
	; Sum
	; ��������� ������������ ������

    WRITE_STRING promt3
	mov ecx, n
	mov esi, OFFSET b	; ��������� � ESI ��������� ����� ������� "�"
	mov edi, OFFSET a	; ��������� � EDI ��������� ����� ������� "b"
sum:
	mov eax, [esi]		; ����� �� ������ �� ������ � ESI - � EAX
	add [edi], eax		; ���������� � ������ �� ������ �� ������ � EDI � ���� �� ����� ���������

	WRITE_NUMBER [edi]	; ����� �� ����� ����� �� ������ � ������� �� EDI
	NEW_LINE
	
	add esi, 4			; ��������� � ������ ���������� �������� ������� "�" - + 4 �����
	add edi, 4			; ��������� � ������ ���������� �������� ������� "b" - + 4 �����
	loop sum			; ����������� ���� �� ��������� ��� �������� (ECX = 0)
		
	READLN_CONSOLE
	INVOKE ExitProcess, 0

WinMain ENDP
end WinMain