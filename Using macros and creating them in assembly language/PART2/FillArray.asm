.686
.model flat, stdcall
include		macroses.inc

.data
include vars.inc
mas DB 36 DUP(' ') 		 ; массив из 36-ти элементов "байт", все элементы 
						 ; которой инициализированы как "пробел"
promt DB 'Input [#,#]th element: ' ; строка для вывода на экран приглашений ввести элемент

.code
include procedures.inc

WinMain PROC

	INIT_CONSOLE
	
	mov ecx, 9
	mov bl, '1'   ; загрузка номера столбца вводимого элемента
	mov bh, '1'	 ; загрузка номера строки вводимого элемента 
	xor esi, esi

start:	
	push ecx
	mov [promt+7], bl	; загрузка номера столбца элемента в строку вывода вместо #
	mov [promt+9], bh	; загрузка номера строки элемента в строку вывода вместо #
	
	WRITE_STRING promt
	mov edi, OFFSET buf  ; переменная определена в файле varc.inc как строка 11 символов
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

	
	READLN_CONSOLE				; ждем нажатия клавиши ВВОД
	INVOKE ExitProcess, 0		; вызов функции для завершения приложения

WinMain ENDP

end WinMain