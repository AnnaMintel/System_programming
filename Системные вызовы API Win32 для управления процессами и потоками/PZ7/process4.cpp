//#include "stdafx.h"
#include "windows.h"
#include "stdio.h"
#include <conio.h>

void main()
{
	STARTUPINFOA cif;
	ZeroMemory(&cif, sizeof(STARTUPINFOA));
	PROCESS_INFORMATION pi;
	HANDLE proc_h;	//переменная для сохранения описателя своего процесса

	proc_h = GetCurrentProcess();	// получение описателя своего процесса
	// его можно использовать в функциях управления приоритетом своего процесса

	if (CreateProcessA("c:\\windows\\notepad.exe", NULL,
		NULL, NULL, FALSE, NULL, NULL, NULL, &cif, &pi) == TRUE) //создание процеса "notepad"
	{
		printf("Process notepad started");     // 
		Sleep(30000);	// подождать 5 сек ТО ЕСТЬ ЕСЛИ НУЖНО 30СЕК, МЕНЯЕМ ЗДЕСЬ

	//параметр pi.hProcess в функции TerminateProcess соответствует описателю 	//процесса notepad.exe 
	//и его также можно использовать в функциях для изменения приоритета блокнота

		TerminateProcess(pi.hProcess, NO_ERROR);	// убрать процесс
		printf(" Process notepad Terminated ");
	}
	if (SetPriorityClass(proc_h, HIGH_PRIORITY_CLASS) == TRUE) printf("Class Priority is HIGH");
	// установить приоритет своего процесса - HIGH
	_getch();
}
