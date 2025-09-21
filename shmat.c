#include "types.h"
#include "user.h"
#include "syscall.h"

int main(){
	shminfo();
	int id = shmget(1, 12288, IPC_CREAT|IPC_EXCL);
	if(id<0){
		printf(1,"error");
		exit();
	}
	printf(1, "created segment with id: %d\n", id);
	// const void* addr = (void*)0x80000100;
	// void* va = shmat(id, 0, 0);
	void* va = shmat(id, 0  , SHM_RND);
	printf(1,"\nva = %p\n", va);
	shminfo();
	printf(1,"\nCalling dt");
	shmdt((int)va);
	va = shmat(id, 0 , SHM_RND);
	// shmdt((int)va);
	// shminfo();
	// removeshm(id, 0);
	// shminfo();
	// id = shmget(1, 12288, IPC_CREAT);
	// printf(1, "created segment with id: %d\n", id);
	// const void* addr = (const void*) 0x70000001;
	// va = shmat(id, addr, 0);
	// printf(1,"va = %p\n", (int)va);
	// shminfo();
	// printf(1,"\n\nfork\n");
	// int pid = fork();
	// if(pid == 0 ){
	// 	int id1 = shmget(IPC_PRIVATE, 8096, IPC_CREAT | IPC_EXCL);
	// 	printf(1, "created segment with id: %d\n", id1);
	// 	void* va1 = shmat(id1, (void*)1, 0);
	// 	printf(1,"va1 = %p\n", (int)va1);
	// 	shminfo();
	// 	exec("/ipcs", args);
	// }
	// else{
	// 	wait();
	// 	int id2 = shmget(IPC_PRIVATE, 8096, IPC_CREAT | IPC_EXCL);
	// 	printf(1, "created segment with id: %d\n", id2);
	// 	void* va1 = shmat(id2, 0, 0);
	// 	printf(1,"va1 = %p\n", (int)va1);
	// 	shminfo();
	// }
	
	// int id0 = shmget(1, 12288, IPC_CREAT | IPC_EXCL);
	// printf(1, "created segment with id0: %d\n", id0);
	// void* va0 = shmat(id0, 0, 0);
	// printf(1,"va = %p\n", (int)va0);
	// shminfo();
	// int id1 = shmget(IPC_PRIVATE, 8096, IPC_CREAT | IPC_EXCL);
	// printf(1, "created segment with id: %d\n", id1);
	// void* va1 = shmat(id1, 0, 0);
	// printf(1,"va1 = %p\n", (int)va1);
	// shminfo();
	// printf(1,"\n\nfork\n");
	// fork();
	// shmdt((int)va1);
	// shminfo();
	// int id2 = shmget(1, 12288, IPC_CREAT | IPC_EXCL);
	// printf(1, "created segment with id2: %d\n", id2);
	// void* va2 = shmat(id2, 0, 0);
	// printf(1,"va = %p\n", (int)va2);
	// shminfo();
	// int id3 = shmget(1, 12288, IPC_CREAT | IPC_EXCL);
	// printf(1, "created segment with id3: %d\n", id3);
	// void* va3 = shmat(id3, 0, 0);
	// printf(1,"va = %p\n", (int)va3);
	// shminfo();

	exit();
}
