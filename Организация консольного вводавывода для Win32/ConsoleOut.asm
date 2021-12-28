; Программа демонстрирует вывод на экран текста и чисел и реализует простое увеличение регистра EAX

.686		; используем инструкции для процессора Intel Pentium IV
.model flat, stdcall	; используем "плоскую" модель памяти и способ вызова функций для Win32
;
; Блок подключения заголовочных файлов и библиотек
include	macroses.inc		; подключение файла со встроенными константами Win API

; Сегмент данных
.data
include vars.inc            ; подключение файла со стандартными переменными
promt DB 'Input the number: '  ; определение строковой переменной promt

; Сегмент кода
.code
include procedures.inc      ; подключение файла со стандартными процедурами

WinMain PROC				; точка входа в приложение

	INIT_CONSOLE			; макрос для инициализации консоли
	
	WRITE 'Вывод строки...'
 	WRITELN 'Вывод строки и переход на новую строку...'
	
	WRITE_STRING promt	    ; вывод строки-переменной promt
	
	INVOKE READNUMBER		; чтение целого числа, результат помещается в eax
	
	WRITE 'Введенное число = '
	WRITE_NUMBER eax
	NEW_LINE                ; переход на новую строку
	
	WRITE 'Считалочка: '
	xor eax, eax            ; обнуляем eax
	WRITE_NUMBER eax        ; выводим число на экран - начинаем с 0
	WRITE_COMMA             ; выводим запятую
	WRITE_SPACE             ; выводим пробел
		; все это можно было вывести через WRITE ', ' но это для показа других макросов WRITE
	inc eax                 ; увеличиваем (инкрементируем) eax на 1
	WRITE_NUMBER eax  ; выводим число на экран - это будет 1
	WRITE ', ' ; вот и как раз вышеуказанный аналог WRITE_SPACE и WRITE_COMMA
	
	inc eax	;
	WRITE_NUMBER eax   ; выводим число на экран - это будет 2
	WRITE ', '
	
	inc eax
	WRITE_NUMBER eax ; выводим число на экран - это будет 3
	WRITE ', '

	inc eax
	WRITE_NUMBER eax ; выводим число на экран - это будет 4
	WRITE ', '
	
	inc eax
	WRITE_NUMBER eax ; выводим число на экран - это будет 5
	WRITE '...'
	
	NEW_LINE
	NEW_LINE
	WRITE 'Конец.'
	
	READLN_CONSOLE         	 ; макрос для ожидания нажатия ENTER
	INVOKE ExitProcess, 0	; вызов функции для завершения приложения
WinMain ENDP			; конец процедуры WinMain

end	WinMain			; конец программы
