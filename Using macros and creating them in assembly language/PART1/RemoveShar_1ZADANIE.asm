.686
.model flat, stdcall
include macroses.inc

.data
include vars.inc
mes DB 50 DUP (?)
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

READ_STRING mes

lea esi, mes
mov ecx, SIZEOF mes
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

; ������ ��� ������ ������ �� �������
;
; PARAM - ������
;
; ������ ������ - WRITE_STRING MACRO PARAM

WRITE_STRING mes

    READLN_CONSOLE
    INVOKE READNUMBER
    INVOKE ExitProcess, 0

WinMain ENDP
end WinMain