; Программа вычисления поэлементной суммы массивов
.686
.model flat, stdcall
include macroses.inc

.data
include vars.inc

n EQU 5			; Задаем константу n равную 5
a DD n DUP(?)	; Задаем массив "а" из n элементов, каждый элемент длиной 32 бита (DD), неинициализирован (?)
b DD n DUP(?)	; Задаем массив "b" из n элементов, каждый элемент длиной 32 бита (DD), неинициализирован (?)
d DD n DUP(?)	; Задаем массив "d" из n элементов, каждый элемент длиной 32 бита (DD), неинициализирован (?)

promt1 DB 'vvedite elementy massiva A',13,10 ; задаем строковые переменные для вывода на экран
promt2 DB 'vvedite elementy massiva B',13,10
promt3 DB 'vvedite elementy massiva C',13,10

VVOD_MASSIVE MACRO name
LOCAL input1
mov ecx, n			; загружаем в ЕСХ число n - число элементов массивов равно 5
	mov ebx, OFFSET name	; загружаем в EBX начальный адрес массива "NAME"
input1:
	INVOKE READNUMBER	; читаем введенное число 
	mov [ebx], eax		; и пишем его в ячейку, адрес которой сейчас в EBX
	add ebx, 4			; увеличиваем значение адреса в EBX на 4 (каждое число массива по 4 байта - 32 бита (DD)
	loop input1			; циклимся пока не переберем все элементы (пока ECX не станет равным 0)
ENDM


.code
include procedures.inc

WinMain PROC

	INIT_CONSOLE

	;
	; Input A
	;

	WRITE_STRING promt1 ; Вывод на экран переменой promt1 - ввести элементы массива "а"
	VVOD_MASSIVE a

	;
	; Input B	;
	; По такой же схеме реализуем ввод матрицы В

	WRITE_STRING promt2
	VVOD_MASSIVE b
	
	;
	; Input d	;
	; По такой же схеме реализуем ввод матрицы d

  	WRITE_STRING promt3
	VVOD_MASSIVE d
		
	READLN_CONSOLE
	INVOKE READNUMBER
	INVOKE ExitProcess, 0

WinMain ENDP
end WinMain