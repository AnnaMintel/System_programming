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
	
	WRITE_STRING promt	    ; вывод строки-переменной promt
	INVOKE READNUMBER		; чтение целого числа, наше ПЕРВОЕ число

	WRITE_STRING promt	    ; вывод строки-переменной promt
	INVOKE READNUMBER		; чтение целого числа, наше ВТОРОЕ число

	WRITE_STRING promt	    ; вывод строки-переменной promt
	INVOKE READNUMBER		; чтение целого числа, наше ТРЕТЬЕ число 


	
	
	READLN_CONSOLE         	 ; макрос для ожидания нажатия ENTER
	INVOKE ExitProcess, 0	; вызов функции для завершения приложения
WinMain ENDP			; конец процедуры WinMain

end	WinMain			; конец программы