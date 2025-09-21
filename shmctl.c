#include "types.h"
#include "user.h"
#include "syscall.h"

int main(){
	int id = shmget(1, 12288, IPC_CREAT);
	printf(1, "created segment with id: %d\n", id);
	void* va = shmat(id, 0, 0);
	printf(1,"va = %p\n", (int)va);
	shminfo();
    struct shmid_ds buf;
	shmctl(id, IPC_STAT, &buf);
    printf(1, "shmid_ds\n key: %d\n mode: %d\n size: %d\n atime: %d\n dtime: %d\n ctime: %d\n cpid: %d\n lpid: %d\n pa: %p\n", buf.shm_perm.__key, buf.shm_perm.mode, buf.shm_segsz, buf.shm_atime, buf.shm_dtime, buf.shm_ctime, buf.shm_cpid, buf.shm_lpid, buf.pa);
    shmctl(id, SHM_INFO, &buf);
    shmctl(id, IPC_RMID, &buf);
    shminfo();
    shmctl(id, IPC_STAT, &buf);
    shmctl(id, IPC_INFO, &buf);
    printf(1, "shmid_ds\n key: %d\n mode: %d\n size: %d\n atime: %d\n dtime: %d\n ctime: %d\n cpid: %d\n lpid: %d\n pa: %p\n", buf.shm_perm.__key, buf.shm_perm.mode, buf.shm_segsz, buf.shm_atime, buf.shm_dtime, buf.shm_ctime, buf.shm_cpid, buf.shm_lpid, buf.pa);

    exit();
}
