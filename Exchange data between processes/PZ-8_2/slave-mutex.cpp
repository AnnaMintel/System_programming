//#include "stdafx.h"
#include "windows.h"
#include "stdio.h"
#include <conio.h>

void main()
{
	printf ("Process 2 running ");
	HANDLE Hmutex=CreateMutexA(NULL, false, "MyMutex");
	if ( Hmutex!=0 ) 
	{ printf ("Mutex-2 created and stopped ");//
	  DWORD MM=WaitForSingleObject(Hmutex, 9000); //запросить мьютекс и ожидать его освобождения до 9 сек
	  printf ("Mutex-2 release and Program2 continue ");//
	  int  i=0;
        while (i<10)
        {
         printf ("+"); //
         i= i++;
	     Sleep(1000); // подождать 1 сек
        }
	}
  
	_getch();
}