#include "types.h"
#include "user.h"

int main(int argc, char *argv[]){
	if(argc < 3){
		printf(1, "Please provide shmid or shmkey as first argument and set second argument as 0 for shmid and 1 for shmkey\n");
		exit();
	}

	int r = removeshm(atoi(argv[1]), atoi(argv[2]));

	if(r == -1){
		printf(1, "Failed to remove the shm segment\n");
	}
	else{
		printf(1, "Removed the shm segment\n");
	}

	exit();
}
