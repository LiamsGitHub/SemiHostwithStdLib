#include <stdio.h>

int main()
{
	int j=0;
	int k=0;

	while(1)
	{
		printf("std lib test  %d \n",j++);


		for (k=0;k<100000;k++);

	}

	return 0;
}

#ifndef __NO_SYSTEM_INIT
void SystemInit()
{}
#endif
