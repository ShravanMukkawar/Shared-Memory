// Memory layout

#define EXTMEM  0x100000            // Start of extended memory
#define PHYSTOP 0xE000000           // Top physical memory
#define DEVSPACE 0xFE000000         // Other devices are at high addresses

// Key addresses for address space layout (see kmap in vm.c for layout)
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#define V2P(a) (((uint) (a)) - KERNBASE)
#define P2V(a) ((void *)(((char *) (a)) + KERNBASE))

#define V2P_WO(x) ((x) - KERNBASE)    // same as V2P, but without casts
#define P2V_WO(x) ((x) + KERNBASE)    // same as P2V, but without casts

// Macros for shared memory:
#define HEAPLIMIT 0x7F000000        // This is the limit upto which allocuvm can grow the size, the remaining memory (KERNBASE - HEAPLIMIT = 16MB <==> 4096 Pages) is for shared memory usage
#define SHMMAXSEG 4096              // maximum segment count = 16MB/PGSIZE = 4096
#define SHMMIN 1024                 // in KBs
#define MAXSEGSIZE (16*1024*1024)   // maximum segement size in Bytes (initially)
