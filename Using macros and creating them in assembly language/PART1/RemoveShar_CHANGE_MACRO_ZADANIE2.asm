.686
.model flat, stdcall
include macroses.inc

.data
include vars.inc
mes DB 50 DUP (?)
mes1 DB 50 DUP (?)
mes2 DB 50 DUP (?)

PREOBR MACRO  param1 ; ������ �� �������������� ������ �� ��� ���� ���� � �������
LOCAL start, skip
lea esi, param1
mov ecx, SIZEOF param1
start:
mov al, [esi]
cmp al, 'a'
jb skip
cmp al, 'z'
ja skip
sub al, 32
mov [esi], al
skip:
inc esi
loop start
ENDM


.code
include procedures.inc

WinMain PROC

    INIT_CONSOLE

; ������ ��� ������ ������ � ����������
;
; PARAM1 - ����� ��� ����� (��� ������� �� ��� ����� ������)
; �����: eax - ������ ��������� ������
;
; ������ ������ - READ_STRING MACRO PARAM1 

WRITE '��E���� ������ '
READ_STRING mes
WRITE '��E���� ������ '
READ_STRING mes1
WRITE '��E���� ������ '
READ_STRING mes2

PREOBR mes
PREOBR mes1
PREOBR mes2

; ������ ��� ������ ������ �� �������
;
; PARAM - ������
;
; ������ ������ - WRITE_STRING MACRO PARAM

WRITE_STRING mes
WRITE_STRING mes1
WRITE_STRING mes2

    READLN_CONSOLE
    INVOKE READNUMBER
    INVOKE ExitProcess, 0

WinMain ENDP
end WinMain