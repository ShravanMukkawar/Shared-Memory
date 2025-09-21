#include "types.h"
#include "user.h"

int main(int argc, char *argv[]){
	if(argc < 2){
		printf(1, "Please provide segment size(in KBs) as argument.\n");
		exit();
	}
	int size = atoi(argv[1]);
	int shm_key = IPC_PRIVATE;

	int shmflag = IPC_CREAT | SHM_R;
	int shmid = shmget(shm_key, size, shmflag);

	if(shmid < 0){
		printf(1, "Failed to create shared memory segemnt\n");
		exit();
	}
	printf(1, "Shared memory id: %d\n", shmid);

	exit();
}
