.686
.model flat, stdcall
include macroses.inc

.data
include vars.inc
mes DB 50 DUP (?)
mes1 DB 50 DUP (?)
mes2 DB 50 DUP (?)

PREOBR MACRO  param1 ; макрос по преобразованию строки из мал англ букв в большие
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

; МАКРОС для чтения строки с клавиатуры
;
; PARAM1 - буфер для ввода (имя массива по мах длине строки)
; ВЫХОД: eax - размер введенной строки
;
; пример вызова - READ_STRING MACRO PARAM1 

WRITE 'ВВEДИТЕ СТРОКУ '
READ_STRING mes
WRITE 'ВВEДИТЕ СТРОКУ '
READ_STRING mes1
WRITE 'ВВEДИТЕ СТРОКУ '
READ_STRING mes2

PREOBR mes
PREOBR mes1
PREOBR mes2

; МАКРОС для вывода строки на консоль
;
; PARAM - строка
;
; пример вызова - WRITE_STRING MACRO PARAM

WRITE_STRING mes
WRITE_STRING mes1
WRITE_STRING mes2

    READLN_CONSOLE
    INVOKE READNUMBER
    INVOKE ExitProcess, 0

WinMain ENDP
end WinMain