.686
.model flat, stdcall
include		macroses.inc

.data
include vars.inc
mas DB 36 DUP(' ') 		 ; ������ �� 36-�� ��������� "����", ��� �������� 
						 ; ������� ���������������� ��� "������"
promt DB 'Input [#,#]th element: ' ; ������ ��� ������ �� ����� ����������� ������ �������

.code
include procedures.inc

WinMain PROC

	INIT_CONSOLE
	
	mov ecx, 9
	mov bl, '1'   ; �������� ������ ������� ��������� ��������
	mov bh, '1'	 ; �������� ������ ������ ��������� �������� 
	xor esi, esi

start:	
	push ecx
	mov [promt+7], bl	; �������� ������ ������� �������� � ������ ������ ������ #
	mov [promt+9], bh	; �������� ������ ������ �������� � ������ ������ ������ #
	
	WRITE_STRING promt
	mov edi, OFFSET buf  ; ���������� ���������� � ����� varc.inc ��� ������ 11 ��������
	INVOKE ReadConsoleA, stdin, edi, SIZEOF buf, OFFSET cWritten, NULL
	mov eax, cWritten
	mov BYTE PTR [edi+eax-2], 0
	mov ax, WORD PTR [edi]

	mov WORD PTR [mas+esi], ax

	.IF bh=='3'
		mov bh, '1'
		inc bl
	.ELSE
		inc bh
	.ENDIF
	
	add esi, 4
	pop ecx
	loop start

	mov esi, OFFSET mas
	mov ecx, 3

start2:
	push ecx
	WRITE_CONSOLE esi, 12
	NEW_LINE
	add esi, 12
	pop ecx
	loop start2

	
	READLN_CONSOLE				; ���� ������� ������� ����
	INVOKE ExitProcess, 0		; ����� ������� ��� ���������� ����������

WinMain ENDP

end WinMain