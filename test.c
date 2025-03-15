#include<stdio.h>
#include<sys/shm.h>
#include<string.h>
int main(){

	int idx=shmget(1234,1024,IPC_CREAT | 0666);
	if(idx==-1){
		perror("shmget"); 
        	return 1;
	}
        printf("Shared memory segment created with ID: %d\n", idx);

	char *shm=shmat(idx,NULL,0);
	char *messg="Hello Shravan";
	strcpy(shm,messg);
	
	return 0;
	}