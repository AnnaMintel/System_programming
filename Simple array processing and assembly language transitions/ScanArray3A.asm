.686
.model flat, stdcall
include	macroses.inc

.data
include vars.inc

n EQU 20 
mas DD n DUP(?)
razmer DD 0

.code
include procedures.inc

WinMain PROC
	
	INIT_CONSOLE
	WRITE 'Введите размер массива (от 2 до 20) - '
	INVOKE READNUMBER
	mov razmer, eax

	WRITELN  'Введите элементы массива : '
	mov ecx, razmer
	mov ebx, OFFSET mas
input1:
	INVOKE READNUMBER
	mov [ebx], eax
	add ebx, 4
	loop input1

	lea esi, mas	; загружаем в регистр ESI начальный адрес массива 
	mov ecx, SIZEOF mas	; определяем размерность массива и заносим ее в регистр EСX
	xor edx, edx		; обнуление регистра EDX - подготовка для подсчета "ненулей"

start:
	mov al, [esi] ; значение младшей части элемента массива, расположенного по адресу в регистре ESI- в регистр AL
	inc esi       ; увеличиваем адрес очередного элемента массива
	cmp al, 5			; сравнение с нулем
	jle skip		; переход если равно (ноль) - обход увеличения EDX
	inc edx		; увеличение счетчика ненулевых если CMP дал не ноль		
skip:
	loop start			; если ECX больше нуля - не последний элеиент массива, 
						; то переходим на метку start и уменьшаем ECX на 1, если ECX=0 - последний элемент
	WRITELN	' '
	WRITE 'Число элементов массива больше, чем 5 = '
	WRITE_NUMBER edx
	
	READLN_CONSOLE
    INVOKE ExitProcess, 0
WinMain ENDP

end WinMain