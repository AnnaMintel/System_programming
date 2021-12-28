; ПРОЦЕДУРА для перекодировки ANSI-строк в ASCII-строки
; ВХОД:
; PARAM1 - адрес строки для преобразования
; PARAM2 - размер строки
;
; ВЫХОД:
; Преобразованная строка записывается по прежднему адресу
;
ConvertToRus PROC USES ebx ecx PARAM1:DWORD, PARAM2:DWORD

    mov ebx, PARAM1
    mov ecx, PARAM2

start_loop:
    mov al, [ebx]
    
	.IF (al>='А' && al<='Я') || (al>='а' && al<='п')
        sub al, 64
	    mov [ebx], al
	.ENDIF
    
	.IF al>='р' && al<='я'
        sub al, 16
	    mov [ebx], al
	.ENDIF
		
	inc ebx
    loop start_loop

    ret
ConvertToRus ENDP

; ПРОЦЕДУРА (вспомогательная) для вывода непосредственно заданной строки на экран
; ВХОД:
; PARAM1 - адрес строки для вывода
; PARAM2 - размер строки
;
; ВЫХОД:
; Вывод на экран
;
OutputString PROC USES ecx esi edi PARAM1:DWORD, PARAM2:DWORD
  
  mov esi, PARAM1
  mov ecx, PARAM2
  lea edi, _strbuf

  cld
  rep movsb
  RUS <_strbuf>
  WRITE_CONSOLE OFFSET _strbuf, PARAM2

  ret
OutputString ENDP

;
; ПРОЦЕДУРА для конвертации шестнадцатеричного числа в ASCII
; ВХОД:
; PARAM1:DWORD - число для преобразования
; ВЫХОД:
; [ebx] - адрес выходной строки
; eax   - длина строки
;
POSITIVE_HEX2ASCII PROC USES ecx edx edi PARAM1:DWORD
	
	mov eax, PARAM1	; исходное число - в eax
	lea ebx, buf+11	; загружаем адрес "конца" буфера (будем заполнять справа-налево)
	mov  edi, 10	; делитель будем хранить в edi
	xor ecx, ecx	; обнуление счетчика

_label1:
	dec ebx			; изменяем адрес текущего символа в строке-приемнике
	xor  edx, edx	; готовим пару edx:eax для деления
					; обнуляем edx, т.е. старшую часть делимого
	
	div  edi		; проводим деление, теперь в eax - частное, edx - остаток

    add dl, '0'		; "волшебное" число - разница в таблице ASCII между '0' и 0
	mov [ebx], dl	; помещаем байт в буфер

	inc ecx			; увеличиваем счетчик, т.е. длина строки увеличилась на 1
	cmp eax, 0		; если частное еще не нулевое
	jnz _label1		; то переходим к началу цикла
	
	mov eax, ecx	; сохраняем длину строки в eax
	
	ret
POSITIVE_HEX2ASCII ENDP


;
; ПРОЦЕДУРА для конвертации шестнадцатеричного числа в ASCII
; ВХОД:
; PARAM1:DWORD - число для преобразования
; ВЫХОД:
; [ebx] - адрес выходной строки
; eax   - длина строки
;
HEX2ASCII PROC PARAM1:DWORD
	
    mov eax, PARAM1
	cmp eax,0
	jge _positive
	
	neg eax
	INVOKE POSITIVE_HEX2ASCII, eax
	inc eax
	dec ebx
	push eax
	mov al, '-'
	mov [ebx], al
	pop eax

	jmp _finish
	
_positive:		
	INVOKE POSITIVE_HEX2ASCII, eax
	
_finish:
	ret
HEX2ASCII ENDP


;
; ПРОЦЕДУРА для чтения 32-битного числа с клавиатуры
; ВЫХОД:
; eax - введенное число
;
READNUMBER PROC USES ebx ecx edx esi edi
		
	mov esi, OFFSET buf
	
	INVOKE ReadConsoleA, stdin, OFFSET buf, SIZEOF buf, OFFSET cWritten, NULL
	
	mov eax, cWritten
	mov BYTE PTR [esi+eax-2], 0

	xor edi, edi    ; edi=0 - число положительное
	mov al, [esi]   ; проверяется первый символ
	.IF al=='-'     ;
      inc esi       ; если первый символ '-', то пропускаем его
	  inc edi       ; edi=1 - число отрицательное
	.ENDIF          ;
		
	xor eax, eax	;
	xor ebx, ebx	;
	xor edx, edx	; подготовка регистров к преобразованию
	mov ecx, 10		; ecx будет хранить делитель

_START:
	mov bl,[esi]	; загружаем очередной символ

	cmp bl,0
	je  _DONE       ; если это конец строки - выход
	cmp bl,'0'
	jl  _DONE		; если символ меньше '0' - выход
	cmp bl,'9'
	jg  _DONE		; если символ больше '9' - выход

	sub bl,'0'      ; "волшебное" число - разница в таблице ASCII между '0' и 0
	mul ecx			; умножается eax*ecx, результат помещается в edx:eax
	add eax, ebx    ; добавляем новый разряд
	
	inc esi			; переходим к новому символу
	jmp _START      ; в начало цикла

_DONE:
	
	.IF edi==1      ; если число отрицательное
      neg eax       ; то инвертируем результат
	.ENDIF          ;

	ret
READNUMBER ENDP


;
; ПРОЦЕДУРА для генерации случайного числа
;
; ВХОД:
; Range - верхняя граница
;
; ВЫХОД: 
; eax - случайное число от 0 до Range-1
;
; ПРИМЕР:
; INVOKE Random, 10
; 
Random PROC USES ebx ecx edx Range:SDWORD
    
	;
	; Если на входе <=0, то на выходе 0
	;
	.IF Range <=0
	  xor eax, eax
	  jmp _exit_random
	.ENDIF
	
	;
	; В eax помещается текущее время в миллисекундах
	;
	INVOKE GetTickCount
	
	;
	; Генерируем 32-битное случайное число и обновляем _rSeed
	;	
	add eax, _rSeed
	mov edx, 8405h
	mul edx
	inc eax
	and eax, 7FFFFFFFh
	mov _rSeed, eax

	;
	; Переводим полученное случайное число в диапазон 0..Range-1
	;
	xor edx, edx
	mov ebx, Range
	div ebx
	mov eax, edx

_exit_random:	
	ret
Random ENDP

;
; ПРОЦЕДУРА для генерации случайного числа
;
; ВХОД:
; Range - верхняя граница; -Range - нижняя граница
;
; ВЫХОД: 
; eax - случайное число от -Range+1 до Range-1
;
; ПРИМЕР:
; INVOKE RandomN, 10
; 
RandomN PROC Range:SDWORD
    
	;
	; Если на входе <=0, то на выходе 0
	;
	.IF Range <= 0
	  xor eax, eax
	  jmp _exit_random_n
	.ENDIF
	
	INVOKE Random, 101
	
	and eax, 1
	
	je POS_NUM
	INVOKE Random, Range
	neg eax
	jmp _exit_random_n
POS_NUM:
	INVOKE Random, Range

_exit_random_n:	
	ret
RandomN ENDP