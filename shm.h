struct ipc_perm {
        int         __key;       /* Key supplied to shmget */
        uint mode;               /* Permissions + SHM_DEST flags */
};

// struct to store info about the shared memory segments created
struct shmid_ds {
    struct ipc_perm shm_perm;    /* Permissions */
    uint          shm_segsz;     /* Size of segment (bytes) */
    int          shm_atime;      /* Last attach time */
    int          shm_dtime;      /* Last detach time */
    int          shm_ctime;      /* Creation time/time of last modification via shmctl() */
    int           shm_cpid;      /* PID of creator */
    int           shm_lpid;      /* PID of last shmat/shmdt */
    uint        shm_nattch;      /* No. of current attaches */
    void* 	pa;              /* Physical address of the page in shm segment */
};

// shared memory page table to hold the details of shared memory segments created
struct shmpgtable {
	struct spinlock lock;					/* Lock to protect the shared memory page table */
	struct shmid_ds shm_segs[SHMMAXSEG];	/* Array of shmid_ds to store info about the segment to which that particular part of segment of size PGSIZE is allocated */
	int lastShmSegIndex;                   /* stores index of last allocated segment id in shm_segs */
} shmpgtable = {
	.lastShmSegIndex = -1
};


// struct to store system wide info about the shared memory parameters and limits
struct ipc_info {
	uint shmmax;		/* Maximum segment size */
	uint shmmin;		/* Minimum segement size */
	uint shmmni;		/* Maximum number of segments */
	uint shmseg;		/* Maximum number of segments that a process can attach */
	uint shmall;		/* Maximum number of pages of shared memory */
} ipc_info = {
	.shmmax = MAXSEGSIZE,
	.shmmin = SHMMIN,
	.shmmni = SHMMAXSEG,
	.shmseg = SHMMAXSEG,
	.shmall = SHMMAXSEG
};

// struct to store info about system resources consumed by shared memory
struct shm_info {
	int used_ids;		/* # of currently existing segments */
	uint shm_tot;		/* # of existing shared memory pages */
} shm_info = {
	.used_ids = 0,
	.shm_tot = 0
};

