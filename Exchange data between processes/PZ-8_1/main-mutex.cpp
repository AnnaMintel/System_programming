#include "windows.h"
#include "stdio.h"
#include <conio.h>

void main()
{
	printf ("Process 1 started ");//
	
	HANDLE Hmutex=CreateMutexA(NULL, true, "MyMutex"); //������� ������� � ������ "MyMutex"
	if ( Hmutex!=0 ) 
	{ printf ("Mutex-1 created ");//
	  DWORD MM=WaitForSingleObject(Hmutex, 0); // ��������� ������� 
	  // � ����� ���������� ���������� (TaimOut=0)
	  printf ("Mutex-1 Catch ");//
	}
	
	STARTUPINFOA cif;
	ZeroMemory(&cif,sizeof(STARTUPINFOA));
	PROCESS_INFORMATION pi; //�������������� ��������� � ������� �������� 2
	if (CreateProcessA("PZ-8_2.exe",NULL, // ��������� ������� 2
		NULL,NULL,FALSE,NULL,NULL,NULL,&cif,&pi)==TRUE)
	{
		printf ("Process 2 execute ");//
		Sleep(5000);				// ��������� 5���
		BOOL Sinhro=ReleaseMutex (Hmutex); //���������� ������� ��� �������� 2
		printf ("Mutex-1 Release ");//
   
	_getch();

	TerminateProcess(pi.hProcess,NO_ERROR);	// ������ ������� 2, 
	// pi.hProcess - ��������� ��������� �� ��������� pi

	CloseHandle(Hmutex); // ���������� �������� �������
	
	}
}