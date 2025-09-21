typedef unsigned int   uint;
typedef unsigned short ushort;
typedef unsigned char  uchar;
typedef uint pde_t;
// typedef uint pte_t;

#define SHM_R 01		/* read permission */
#define SHM_W 02		/* write permission */

// FLAGS FOR SHMGET
#define IPC_CREAT 04	 	/* Create if key is nonexistent */
#define IPC_EXCL 16	 	/* Fail if key exists */
#define IPC_PRIVATE -99999	/* Private key */

//ERRORS FOR SHMGET
#define EEXIST -101   /*memory segment already exists for key for IPC_CREAT | IPC_EXCL*/
#define EINVAL -102   /*segment size less than SHMMIN or greater than SHMAX, key exist but size is greater, SHMAT: Invalid segment ID or address*/
#define ENOENT -103   /*no segment for given key and not IPC_CREAT*/
#define ENOMEM -104   /*No memory could be allocated for segment for SHMAT also*/
#define ENOSPC -105   /*All possible shared memory IDs have been taken*/

// FLAGS FOR SHMAT, SHMDT
#define SHM_EXEC 1    /*executable permission for segment*/
#define SHM_RDONLY 2  /*read only permission for the segment*/
#define SHM_REMAP 3   /*replace any segment if already exist at the address*/
#define SHM_RND 4     /*round down the address to multiple of PGSIZE*/
#define SHM_DEST 32   /*mark the segment for destruction*/

//ERRORS FOR SHMAT
#define EIDRM -202      /*Segment has been removed*/

// FLAGS FOR SHMCTL
#define IPC_STAT 1		/* copy info in shmid_ds to the buf */
#define IPC_SET 2		/* copy info in buf to the shmid_ds */
#define IPC_RMID 3		/* mark the segment to be destroyed */
#define IPC_INFO 4		/* copy info in ipc_info to the buf */
#define SHM_INFO 5		/* copy info in shm_info to the buf */

