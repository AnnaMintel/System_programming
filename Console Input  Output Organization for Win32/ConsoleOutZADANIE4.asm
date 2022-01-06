; ��������� ������������� ����� �� ����� ������ � ����� � ��������� ������� ���������� �������� EAX

.686		; ���������� ���������� ��� ���������� Intel Pentium IV
.model flat, stdcall	; ���������� "�������" ������ ������ � ������ ������ ������� ��� Win32
;
; ���� ����������� ������������ ������ � ���������
include	macroses.inc		; ����������� ����� �� ����������� ����������� Win API

; ������� ������
.data
include vars.inc            ; ����������� ����� �� ������������ �����������
promt DB 'Input the number: '  ; ����������� ��������� ���������� promt

; ������� ����
.code
include procedures.inc      ; ����������� ����� �� ������������ �����������

WinMain PROC				; ����� ����� � ����������

	INIT_CONSOLE			; ������ ��� ������������� �������
	
	WRITE '����� ������...'
 	WRITELN '����� ������ � ������� �� ����� ������...'
	
	WRITE_STRING promt	    ; ����� ������-���������� promt
	
	INVOKE READNUMBER		; ������ ������ �����, ��������� ���������� � eax
	
	WRITE '��������� ����� = '
	WRITE_NUMBER eax
	NEW_LINE                ; ������� �� ����� ������

	mov ecx, eax			; ���������� ����� ������
	WRITE '����������: '
	xor eax, eax            ; �������� eax
	WRITE_NUMBER eax        ; ������� ����� �� ����� - �������� � 0
	WRITE_COMMA             ; ������� �������
	WRITE_SPACE             ; ������� ������
		; ��� ��� ����� ���� ������� ����� WRITE ', ' �� ��� ��� ������ ������ �������� WRITE
	
	Metka1 :
	inc eax                 ; ����������� (��������������) eax �� 1
	WRITE_NUMBER eax  ; ������� ����� �� ����� - ��� ����� 1
	WRITE ', ' ; ��� � ��� ��� ������������� ������ WRITE_SPACE � WRITE_COMMA
	loop Metka1  ; �������������, ���� �� ��������� ������� ecx
	
	NEW_LINE
	NEW_LINE
	WRITE '�����.'
	
	READLN_CONSOLE         	 ; ������ ��� �������� ������� ENTER
	INVOKE ExitProcess, 0	; ����� ������� ��� ���������� ����������
WinMain ENDP			; ����� ��������� WinMain

end	WinMain			; ����� ���������