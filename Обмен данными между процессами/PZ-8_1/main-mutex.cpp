#include "windows.h"
#include "stdio.h"
#include <conio.h>

void main()
{
	printf ("Process 1 started ");//
	
	HANDLE Hmutex=CreateMutexA(NULL, true, "MyMutex"); //создать мьютекс с именем "MyMutex"
	if ( Hmutex!=0 ) 
	{ printf ("Mutex-1 created ");//
	  DWORD MM=WaitForSingleObject(Hmutex, 0); // захватить мьютекс 
	  // и сразу продолжить выполнение (TaimOut=0)
	  printf ("Mutex-1 Catch ");//
	}
	
	STARTUPINFOA cif;
	ZeroMemory(&cif,sizeof(STARTUPINFOA));
	PROCESS_INFORMATION pi; //информационная структура с данными процесса 2
	if (CreateProcessA("PZ-8_2.exe",NULL, // запустить процесс 2
		NULL,NULL,FALSE,NULL,NULL,NULL,&cif,&pi)==TRUE)
	{
		printf ("Process 2 execute ");//
		Sleep(5000);				// подождать 5сек
		BOOL Sinhro=ReleaseMutex (Hmutex); //освободить мьютекс для процесса 2
		printf ("Mutex-1 Release ");//
   
	_getch();

	TerminateProcess(pi.hProcess,NO_ERROR);	// убрать процесс 2, 
	// pi.hProcess - описатель процесаса из структуры pi

	CloseHandle(Hmutex); // уничтожить ненужный мьютекс
	
	}
}