//#include "stdafx.h"
#include "windows.h"
#include "stdio.h"
#include <conio.h>

void main()
{
	STARTUPINFOA cif;
	ZeroMemory(&cif, sizeof(STARTUPINFOA));
	PROCESS_INFORMATION pi;
	HANDLE proc_h;	//���������� ��� ���������� ��������� ������ ��������

	proc_h = GetCurrentProcess();	// ��������� ��������� ������ ��������
	// ��� ����� ������������ � �������� ���������� ����������� ������ ��������

	if (CreateProcessA("c:\\windows\\notepad.exe", NULL,
		NULL, NULL, FALSE, NULL, NULL, NULL, &cif, &pi) == TRUE) //�������� ������� "notepad"
	{
		printf("Process notepad started");     // 
		Sleep(30000);	// ��������� 5 ��� �� ���� ���� ����� 30���, ������ �����

	//�������� pi.hProcess � ������� TerminateProcess ������������� ��������� 	//�������� notepad.exe 
	//� ��� ����� ����� ������������ � �������� ��� ��������� ���������� ��������

		TerminateProcess(pi.hProcess, NO_ERROR);	// ������ �������
		printf(" Process notepad Terminated ");
	}
	if (SetPriorityClass(proc_h, HIGH_PRIORITY_CLASS) == TRUE) printf("Class Priority is HIGH");
	// ���������� ��������� ������ �������� - HIGH
	_getch();
}
