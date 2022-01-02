#include <Windows.h>
#include <stdio.h>
#include <conio.h>

typedef int (*function)(int a, int b); // указатель на функцию

int main()
{
	HMODULE hm = LoadLibrary(L"DLLvscode.dll");
	if (hm == NULL) // В условии if проверяем, успешно ли прошла загрузка
	{
		printf("DLLvscode.dll not found!\n"); // Если ничего не загрузилось, то выведем сообщение об ошибке
	}
	else
	{
		function add = (function)GetProcAddress(hm, "add");
		function sub = (function)GetProcAddress(hm, "sub"); // Получаем адрес функций add и sub
		if ((add == NULL) || (sub == NULL)) // проверяем удалось ли получить адреса
		{
			printf("DLLvscode.dll doesn't export add or sub\n");
		}
		else
		{
			int a, b;
			a = 2; 
			b = 3; // Присваиваем значения переменным a и b
			printf("%d + %d = %d\n", a, b, add(a, b));
			printf("%d - %d = %d\n", a, b, sub(a, b)); // вычисляем значения функций add и sub 
		}
	}
	FreeLibrary(hm);
	_getch();
	return 0;
}