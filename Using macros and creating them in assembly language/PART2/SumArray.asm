; Программа вычисления поэлементной суммы массивов
.686
.model flat, stdcall
include macroses.inc

.data
include vars.inc

n EQU 5			; Задаем константу n равную 5
a DD n DUP(?)	; Задаем массив "а" из n элементов, каждый элемент длиной 32 бита (DD), неинициализирован (?)
b DD n DUP(?)	; Задаем массив "b" из n элементов, каждый элемент длиной 32 бита (DD), неинициализирован (?)

promt1 DB 'vvedite elementy massiva A',13,10 ; задаем строковые переменные для вывода на экран
promt2 DB 'vvedite elementy massiva B',13,10
promt3 DB 'Rezyltat',13,10

.code
include procedures.inc

WinMain PROC

	INIT_CONSOLE

	;
	; Input A
	;

	WRITE_STRING promt1 ; Вывод на экран переменой promt1 - ввести элементы массива "а"
	mov ecx, n			; загружаем в ЕСХ число n - число элементов массивов равно 5
	mov ebx, OFFSET a	; загружаем в EBX начальный адрес массива "а"
input1:
	INVOKE READNUMBER	; читаем введенное число 
	mov [ebx], eax		; и пишем его в ячейку, адрес которой сейчас в EBX
	add ebx, 4			; увеличиваем значение адреса в EBX на 4 (каждое число массива по 4 байта - 32 бита (DD)
	loop input1			; циклимся пока не переберем все элементы (пока ECX не станет равным 0)

	;
	; Input B	;
	; По такой же схеме реализуем ввод матрицы В

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
	; Реализуем суммирование матриц

    WRITE_STRING promt3
	mov ecx, n
	mov esi, OFFSET b	; загружаем в ESI начальный адрес массива "а"
	mov edi, OFFSET a	; загружаем в EDI начальный адрес массива "b"
sum:
	mov eax, [esi]		; число из ячейки по адресу в ESI - в EAX
	add [edi], eax		; складываем с числом из ячейки по адресу в EDI и туда же пишем результат

	WRITE_NUMBER [edi]	; Вывод на экран числа из ячейки с адресом из EDI
	NEW_LINE
	
	add esi, 4			; переходим к адресу следующего элемента массива "а" - + 4 байта
	add edi, 4			; переходим к адресу следующего элемента массива "b" - + 4 байта
	loop sum			; зацикливаем пока не переберем все элементы (ECX = 0)
		
	READLN_CONSOLE
	INVOKE ExitProcess, 0

WinMain ENDP
end WinMain