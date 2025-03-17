#include<stdio.h>
#include<sys/shm.h>
#include<string.h>
int main(){


	char *shm=shmat(229433,NULL,0);
	printf("Data written in our memory is %s",shm);
	
	return 0;
	}