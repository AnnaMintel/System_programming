//#include "stdafx.h"
#include <windows.h>
#include "stdio.h"
#include <conio.h> 


void main()
{
	STARTUPINFOA cif;
	ZeroMemory(&cif,sizeof(STARTUPINFOA));
	PROCESS_INFORMATION pi;
	DWORD WINAPI ThreadFuncA(LPVOID); 
    LPVOID tm_A=0;

	HANDLE hThreadA = CreateThread(NULL, 0, ThreadFuncA, tm_A, 0, NULL);
	if ( hThreadA == NULL) printf ("Error start of Thread");
	int count1 = 0; 
	for (int j = 0; j < 10000; ++j) 
			{count1++;
			 printf("+");
			}
	printf(" count1 over ");
	_getch();
}
DWORD WINAPI ThreadFuncA(LPVOID Ipv) 
		{ 
		int count = 0; 
		printf(" Start of Thread_2 ");
		HANDLE hThread = GetCurrentThread();
		int Pr=GetThreadPriority(hThread);
		SetThreadPriority(hThread, 1);
		int Pr1=GetThreadPriority(hThread);
		for (int i = 0; i < 10000; ++i) 
			{count++;
			 printf("-");
			}
		printf(" count2 over ");
		return 0; 
		} 