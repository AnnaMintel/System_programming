.686
.model flat, stdcall
include	macroses.inc

.data
include vars.inc
mas DB 8, 5, 0, 6, 0, 0, 6, 0, 9, -8, 0, 0, 0, 9, 15, 0, 4, -45, -3, 0   ;задаем массив целых чисел 

.code
include procedures.inc

WinMain PROC
	
	INIT_CONSOLE
	WRITE ' оличество ненулевых элементов массива = '

	lea esi, mas	; загружаем в регистр ESI начальный адрес массива 
	mov ecx, SIZEOF mas	; определ€ем размерность массива и заносим ее в регистр E—X
	xor edx, edx		; обнуление регистра EDX - подготовка дл€ подсчета "ненулей"

start:
	mov al, [esi] ; значение младшей части элемента массива, расположенного по адресу в регистре ESI- в регистр AL
	inc esi       ; увеличиваем адрес очередного элемента массива
	cmp al, 0			; сравнение с нулем
	je skip		; переход если равно (ноль) - обход увеличени€ EDX
	inc edx		; увеличение счетчика ненулевых если CMP дал не ноль		
skip:
	loop start			; если ECX больше нул€ - не последний элеиент массива, 
						; то переходим на метку start и уменьшаем ECX на 1, если ECX=0 - последний элемент
	WRITE_NUMBER edx	; вывод на экран количества ненулей в массиве
	
	READLN_CONSOLE
    INVOKE ExitProcess, 0
WinMain ENDP

end WinMain