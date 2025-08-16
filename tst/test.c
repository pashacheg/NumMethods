#include <stdio.h>
#include <pthread.h>

void* thrF(void* data)
{
	printf("this is thread\n");
	
	return 0;
}

int main()
{
	pthread_t thr;
	
	int res = pthread_create(&thr, NULL, thrF, NULL);
	printf("%d\n", res);
}
