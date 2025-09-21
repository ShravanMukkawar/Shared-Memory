#include "types.h"
#include "user.h"
#include "syscall.h"

int main(){
	//int id = shmget(1,8192,1);
	//printf(1,"%d\n",id);
	//void *addr = shmat(id,0,0);
	//printf(1,"%d\n",addr);
	shminfo();
	exit();
}
