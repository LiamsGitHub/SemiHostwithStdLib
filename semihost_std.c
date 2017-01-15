/* This project works 24th August 2016 */

#include <stdio.h>

extern	void SemiHost(char* a);

int _write(int file, char *ptr, int len)

//int _putc(int file, char *ptr, int len)
{
	 int todo;
	 for (todo = 0; todo < len; todo++) {
	  SemiHost(ptr++);
	 }
	 return len;
}

void _exit (int n)
{
while(1);
}

int _isatty_r (int fd)
{
return(1);
}

int _lseek_r (int fd, int ptr,int dir)
{
return (0);
}

int _read_r (int fd, char *ptr, int len)
{
  return 0;
}

int _open_r(const char *name, int mode)
{
return(-1);
}

int _close(int fd)
{
return(-1);
}


struct stat
{
};

int _fstat(int file, struct stat *st) {
 return (0);
}


char *heap_end = 0;

void * _sbrk(int incr) {
 extern char __HeapBase; // Defined by the linker
 extern char __HeapLimit; // Defined by the linker
 char *prev_heap_end;

 if (heap_end == 0) {
  heap_end = &__HeapBase;
 }
 prev_heap_end = heap_end;

 if (heap_end + incr > &__HeapLimit) {
  // Heap and stack collision
  return (void *) -1;
 }

 heap_end += incr;
 return (void *) prev_heap_end;
 }


void __end__ (void)
{
	while(1);
}

void end (void)
{
	while(1);
}

//-------------------


int main()
{
	int j=0;
	int k=0;

	while(1)
	{
		printf("This is a longer test1  %d \n",j++);


		for (k=0;k<100000;k++);

	}

	return 0;
}

#ifndef __NO_SYSTEM_INIT
void SystemInit()
{}
#endif
