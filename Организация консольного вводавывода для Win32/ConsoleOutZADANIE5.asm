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
	
	WRITE_STRING promt	    ; ����� ������-���������� promt
	INVOKE READNUMBER		; ������ ������ �����, ���� ������ �����

	WRITE_STRING promt	    ; ����� ������-���������� promt
	INVOKE READNUMBER		; ������ ������ �����, ���� ������ �����

	WRITE_STRING promt	    ; ����� ������-���������� promt
	INVOKE READNUMBER		; ������ ������ �����, ���� ������ ����� 


	
	
	READLN_CONSOLE         	 ; ������ ��� �������� ������� ENTER
	INVOKE ExitProcess, 0	; ����� ������� ��� ���������� ����������
WinMain ENDP			; ����� ��������� WinMain

end	WinMain			; ����� ���������