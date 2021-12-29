;
; Блок подключения заголовочных файлов и библиотек
;
include		windows.inc		; подключаем файл со встроенными константами Win API
includelib	kernel32.lib	; подключаем библиотеку ядра Win32

;
; Описание экспортируемых функций
;
ExitProcess   PROTO :DWORD
AllocConsole  PROTO
GetStdHandle  PROTO :DWORD
WriteConsoleA PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
ReadConsoleA  PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
GetTickCount  PROTO

;
; МАКРОС для инициализации консоли
;
INIT_CONSOLE MACRO
	INVOKE AllocConsole
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov stdout, eax
	INVOKE GetStdHandle, STD_INPUT_HANDLE
	mov stdin, eax
ENDM

;
; МАКРОС для вывода в консоль
;
; PARAM1 - адрес буфера для вывода
; PARAM2 - размер буфера
;
WRITE_CONSOLE MACRO PARAM1, PARAM2
	push eax
	push ecx
	push edx
	INVOKE WriteConsoleA, stdout, PARAM1, PARAM2, OFFSET cWritten, NULL
	pop edx
	pop ecx
	pop eax
ENDM

;
; МАКРОС для вывода строки на консоль
;
; PARAM - строка
;
WRITE_STRING MACRO PARAM
    WRITE_CONSOLE OFFSET PARAM, SIZEOF PARAM	
ENDM

;
; МАКРОС для вывода целого числа на консоль
;
; PARAM - число
;
WRITE_NUMBER MACRO PARAM
	push eax
	push ebx
	INVOKE HEX2ASCII, PARAM
    WRITE_CONSOLE ebx, eax
	pop ebx
	pop eax
ENDM

;
; МАКРОС для перевода каретки на новую строку
;
NEW_LINE MACRO
	WRITE_CONSOLE OFFSET EOL, SIZEOF EOL
ENDM

;
; МАКРОС для печати пробела
;
WRITE_SPACE MACRO
	WRITE_CONSOLE OFFSET SPACE, SIZEOF SPACE
ENDM

;
; МАКРОС для печати запятой
;
WRITE_COMMA MACRO
	WRITE_CONSOLE OFFSET COMMA, SIZEOF COMMA
ENDM

;
; МАКРОС для ожидания нажатия клавиши ВВОД
;
READLN_CONSOLE MACRO
	push eax
	push ecx
	push edx
	INVOKE ReadConsoleA, stdin, OFFSET cEmpty, 0, OFFSET cWritten, NULL
	pop edx
	pop ecx
	pop eax
ENDM

;
; МАКРОС для чтения строки с клавиатуры
;
; PARAM1 - буфер для ввода
; ВЫХОД: eax - размер введенной строки
;
READ_STRING MACRO PARAM1
	push ecx
	push edx	
	
	INVOKE ReadConsoleA, stdin, OFFSET PARAM1, SIZEOF PARAM1, OFFSET cWritten, NULL
	mov eax, cWritten
	sub eax, 2
	
	pop edx
	pop ecx
ENDM

;
; МАКРОС для русификации строк
; PARAM - перечень строк
;
; ИСПОЛЬЗОВАНИЕ: RUS <msg1, msg2, msg3>
;
RUS MACRO PARAM
    IRP i, <PARAM>
        INVOKE ConvertToRus, OFFSET i, SIZEOF i
	ENDM
ENDM

;
; МАКРОС для вывода непосредственно указанной строки на экран
; PARAM - непосредственная строка
;
; ИСПОЛЬЗОВАНИЕ: WRITE 'Hello, world!'
;
WRITE MACRO PARAM
  LOCAL lab 
  LOCAL stroka 

  push eax
  jmp lab
  stroka db param
lab:  
  INVOKE OutputString, OFFSET stroka, SIZEOF stroka
  pop eax
ENDM

;
; МАКРОС для вывода непосредственно указанной строки на экран
; в конце строки каретка переводится на новую строку
; PARAM - непосредственная строка
;
; ИСПОЛЬЗОВАНИЕ: WRITELN 'Hello, world!'
;
WRITELN MACRO PARAM
  WRITE PARAM
  WRITE_STRING EOL
ENDM

;
; МАКРОС для динамического выделения памяти
;
; PARAM1 - переменная, в которую будет сохранен адрес буфера
; PARAM2 - размер буфера в байтах
;
GETMEM MACRO PARAM1, PARAM2
	push eax
	push ecx
	push edx
	
	INVOKE GlobalAlloc, NULL, PARAM2
	.IF eax == NULL
	  WRITE 'Невозможно выделить память!'
	  READLN_CONSOLE
	  INVOKE ExitProcess, 0
	.ELSE
	  mov PARAM1, eax
	.ENDIF
	
	pop edx
	pop ecx
	pop eax
ENDM

;
; МАКРОС для динамического выделения памяти
;
; PARAM - адрес буфера
;
FREEMEM MACRO PARAM
	push eax
	push ecx
	push edx
	INVOKE GlobalFree, PARAM
	pop edx
	pop ecx
	pop eax
ENDM