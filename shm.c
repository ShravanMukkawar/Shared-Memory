#include "param.h"
#include "types.h"
#include "defs.h"
#include "x86.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "elf.h"
#include "spinlock.h"
#include "shm.h"
#include "date.h"

void shminit(){
	initlock(&shmpgtable.lock, "shmpgtable");
}

struct rtcdate r;

uint generate_random_key() {
	cmostime(&r);	
	uint key =  r.second * 10000 + r.minute * 100 + r.hour * 10 + r.day + ticks;
	return key;
}

//Update the segment due to  forked child process
// flag = 0 ==> called through forkS
// flag = 1 ==> called through exec
void updateShmSeg(int shmid, int pid, int flag){
	cmostime(&r);
	int reqPages = shmpgtable.shm_segs[shmid].shm_segsz / PGSIZE;
	acquire(&shmpgtable.lock);
	if (flag == 0){
		for(int i = 0; i < reqPages; i++){
			shmpgtable.shm_segs[shmid + i].shm_nattch += 1;
			shmpgtable.shm_segs[shmid + i].shm_lpid = pid;
			shmpgtable.shm_segs[shmid + i].shm_atime = r.hour*10000+r.minute*100+r.second;	
		}
	}
	else{
		for(int i = 0; i < reqPages; i++){
			shmpgtable.shm_segs[shmid + i].shm_nattch -= 1;
			shmpgtable.shm_segs[shmid + i].shm_dtime = r.hour*10000+r.minute*100+r.second;	
		}
	}
	release(&shmpgtable.lock);
}

// Adds physical address pa of the page of shm segment into shm_segs array at lastShmSegIndex + 1
int mapShmSegPage(struct shmpgtable *shmpagetable, uint pa, int key, int segSize, int index, int pid, int perm){
	acquire(&shmpagetable->lock);
	shmpgtable.shm_segs[index].pa = (void *)pa;
	shmpgtable.shm_segs[index].shm_perm.__key = key;
	shmpgtable.shm_segs[index].shm_perm.mode = perm;
	shmpgtable.shm_segs[index].shm_segsz = segSize;
	shmpgtable.shm_segs[index].shm_lpid = pid;
	// null other fields
	shmpgtable.shm_segs[index].shm_atime = -1;
	shmpgtable.shm_segs[index].shm_dtime = -1;
	shmpgtable.shm_segs[index].shm_ctime = -1;
	shmpgtable.shm_segs[index].shm_cpid = -1;
	shmpgtable.shm_segs[index].shm_nattch = 0;
	release(&shmpagetable->lock);
	return index;
}

// Removes physical address stored in shm_segs array for the range of indices corresponding to allocated shm segment pages
// Called only if kalloc fails in between allocating pages for shm segment
void unmapShmSegPage(struct shmpgtable *shmpagetable, uint endIndex){
	acquire(&shmpagetable->lock);
	while(endIndex != shmpgtable.lastShmSegIndex){
		shmpgtable.shm_segs[endIndex].pa = 0;
		shmpgtable.shm_segs[endIndex].shm_perm.__key = -1;
		shmpgtable.shm_segs[endIndex].shm_segsz = 0;
		shmpgtable.shm_segs[endIndex].shm_perm.mode = 0;
		endIndex--;
	}
	release(&shmpagetable->lock);
}

// Allocate pages for shmget. Return -1 on error.
int allocShmSeg(uint segmentSize, int key, int shmflag){
        if(segmentSize < SHMMIN || segmentSize > MAXSEGSIZE){
                return EINVAL;
        }
		struct proc *process = myproc();

        uint roundedSegSize, a = 0;
        char *mem;
		int incrementLastIndex = 0;

        roundedSegSize = PGROUNDUP(segmentSize);

		// find suitable space to create a new segment
		int index = -1;
		int zc = 0;
		int si = -1;

		int reqPages = roundedSegSize / PGSIZE;

		for(int i = 0; i <= shmpgtable.lastShmSegIndex; i++){
			if(shmpgtable.shm_segs[i].shm_perm.__key == -1){
				if(si == -1){
					si = i;
				}
				zc++;
				if(zc == reqPages){
					index = si;
					break;
				}
			}
			else{
				si = -1;
				zc = 0;
			}
		}

		if(index == -1){
			index = shmpgtable.lastShmSegIndex + 1;
			incrementLastIndex = 1;
		}

		if(index + reqPages > SHMMAXSEG){
			return ENOSPC;
		}

		int shmid = index;

        while(a != roundedSegSize){
                mem = kalloc();
                if(mem == 0){
                      cprintf("allocuvm out of memory\n");
                      unmapShmSegPage(&shmpgtable, (a/PGSIZE));
                      return -1;
                }
                memset(mem, 0, PGSIZE);

                mapShmSegPage(&shmpgtable, V2P(mem), key, roundedSegSize, index, process->pid, (shmflag & 03));

		if(incrementLastIndex){
			shmpgtable.lastShmSegIndex += 1;
		}
		index++;
                a += PGSIZE;
        }

	// update shm_info
	shm_info.used_ids += 1;
	shm_info.shm_tot = shmpgtable.lastShmSegIndex + 1;

        return shmid;
}


void* allocshmuvm(int shmid, void *shmaddr, int reqPages, int si, int shmflag){
	cmostime(&r);
	struct proc *process = myproc();
	void* va = shmaddr;
	acquire(&shmpgtable.lock);
	for(int i = 0; i < reqPages; i++){
		process->shmsegs[si + i].isAttached = 1;
		process->shmsegs[si + i].shmid = shmid;
		// (shmflag & 02) == 1 ==> read and write permission on the shm segment, (shmflag & 02) == 0 ==> only read permission.
		// cprintf("\nva%d",(int)va);
		if(mappages(myproc()->pgdir, (void *)va, PGSIZE, V2P(shmpgtable.shm_segs[shmid + i].pa), ((shmflag & 02) ? (PTE_W|PTE_U) : PTE_U)) < 0){
			deallocuvm(myproc()->pgdir, (uint)va, (uint)shmaddr);
			return (void*)ENOMEM;
		}
		shmpgtable.shm_segs[shmid + i].shm_nattch += 1;
		shmpgtable.shm_segs[shmid + i].shm_atime = r.hour*10000+r.minute*100+r.second;
		shmpgtable.shm_segs[shmid + i].shm_ctime = r.hour*10000+r.minute*100+r.second;
		shmpgtable.shm_segs[shmid + i].shm_lpid = process->pid;
		va += PGSIZE;
	}
	release(&shmpgtable.lock);
	return shmaddr;
}

// Prints the info about all the shm segments using shmpgtable
void shminfoHelper(){
	cprintf("--------------- Shared Memory Segments ---------------\n");
	cprintf("Last segment index: %d\n", shmpgtable.lastShmSegIndex);
	cprintf("------------------------------------------------------\n");


	if(shmpgtable.lastShmSegIndex == -1)
		return;

	cprintf("Key \t Shmid \t Size \t nattach \t lpid\n\n");
	int lastKey = -1;
	for(int i = 0; i <= shmpgtable.lastShmSegIndex; i++){
		int currentKey = shmpgtable.shm_segs[i].shm_perm.__key;

		if(currentKey == -1){
			// this is unallocated
			continue;
		}

		if(lastKey == currentKey){
			// this struct is part of same struct which is already printed
			continue;
		}

		cprintf("%d \t %d \t %d \t %d \t\t %d\n", currentKey, i, shmpgtable.shm_segs[i].shm_segsz, shmpgtable.shm_segs[i].shm_nattch, shmpgtable.shm_segs[i].shm_lpid);

		lastKey = currentKey;
	}

	return;
}

// Helper function for sys_shmget
int shmgetHelper(int key, uint size, int shmflag){
	int shmid = -1;
	int found = 0;
	int i = 0;
	
	if(key == IPC_PRIVATE){
		key = generate_random_key();
	}
	if(shmpgtable.lastShmSegIndex != -1){
		for (i = 0; i <= shmpgtable.lastShmSegIndex; i++){
			if(shmpgtable.shm_segs[i].shm_perm.__key == key){
				found = 1;
				shmid = i;
				break;
			}
		}
	}

	if(shmflag == (IPC_CREAT | IPC_EXCL)){
		// in this case, if segment already exists, the call fails. Otherwies a new segment is created.
		if(found){
			return EEXIST;
		}
		else{
			shmid = allocShmSeg(size, key, shmflag);
			return shmid;
		}
	}
	else if(shmflag == IPC_CREAT){
		// in this case, if segment already exists, returns segment identifier. Otherwise a new segement is created.
		if (found && shmpgtable.shm_segs[i].shm_segsz <= size){
			return shmid;
		}
		else if (found && !(shmpgtable.shm_segs[i].shm_segsz > size)){
			return EINVAL;
		}
		else{
			shmid = allocShmSeg(size, key, shmflag);
			return shmid;
		}
	}
	else{
		// no flag specified, so return segment identifier if segment already exists
		if(found){
			return shmid;
		}
		else{
			return ENOENT;
		}
	}
}

// Helper function for sys_shmat
// Attaches the segement with identifier shmid to the process
// i.e. adds the entries of va to pa mappings in the process uvm
void* shmatHelper(int shmid, int shmaddr, int shmflag){
	// check if the shmid is valid
	if(shmid < 0 || shmid > shmpgtable.lastShmSegIndex){
		return (void*)EINVAL;
	}
	int segsz = shmpgtable.shm_segs[shmid].shm_segsz;

	// check if the segment is created
	if(segsz == 0){
		return (void*)EIDRM;
	}

	int reqPages = segsz / PGSIZE;

	void *va = 0;
	int si = -1;

	struct proc *process = myproc();

	if( shmaddr == 0){
		// address not provided, find suitable address and map the segement
		int index = -1;
		int zc = 0;

		for(int i = 0; i < SHMMAXSEG; i++){
			if(process->shmsegs[i].isAttached == 0){
				if(si == -1){
					si = i;
				}
				zc++;
				if(zc == reqPages){
					index = si;
					break;
				}
			}
			else{
				si = -1;
				zc = 0;
			}
		}

		if(index == -1){
			return (void*)ENOMEM;
		}

		va = (void*) ((index * PGSIZE) + HEAPLIMIT);
	}
	else{
		// address provided, check if it is valid and empty
		if( shmaddr > KERNBASE ||  shmaddr < HEAPLIMIT){
			// cprintf("\n%d",shmaddr > KERNBASE );
			// cprintf("\n%d",shmaddr < HEAPLIMIT );
			// cprintf("\n%d  %d  %d \n", shmaddr, (int)HEAPLIMIT, (int)KERNBASE);
			return (void*)EINVAL;
		}
		if (shmflag != SHM_RND && shmaddr % PGSIZE != 0){
			return (void*)EINVAL;
		}
		if (shmflag == SHM_RND){
			va = (void*)PGROUNDDOWN(shmaddr);
		}
		int given_si = ((int)va - HEAPLIMIT) / PGSIZE;

		for(int i = given_si; i < reqPages; i++){
			if(process->shmsegs[i].isAttached == 1){
				if(shmflag == SHM_REMAP){
					//replace any existing mapping in the range starting at shmaddr  and continuing  for  the  size of the segment
					return (void*)EINVAL;
				}
				else{
					return (void*)EINVAL;
				}
			}
		}
		si = given_si;
	}

	if((va = allocshmuvm(shmid, va, reqPages, si, shmflag)) == 0){
		return (void*)ENOMEM;
	}

	//if (shmflag == SHM_EXEC){
		// Allow the contents of the segment to be  executed. The  caller must have execute permission on the segment.
	//}
	return va;
}

// Helper function for sys_shmdt
int shmdtHelper(int shmaddr){
	if(shmaddr < HEAPLIMIT || shmaddr > KERNBASE){
		return EINVAL;
	}
	
	cmostime(&r);
	struct proc *process = myproc();
	int si = ((uint)shmaddr - HEAPLIMIT) / PGSIZE;
	if(process->shmsegs[si].isAttached == 0){
		return EINVAL;
	}
	int shmid = process->shmsegs[si].shmid;
	process->shmsegs[si].isAttached = 0;
	process->shmsegs[si].shmid= -1;
	int size = shmpgtable.shm_segs[shmid].shm_segsz;
	int reqPages = size / PGSIZE;
	acquire(&shmpgtable.lock);
	for(int i = 0; i < reqPages; i++){
		process->shmsegs[si + i].isAttached = 0;
		shmpgtable.shm_segs[shmid + i].shm_nattch -= 1;
		shmpgtable.shm_segs[shmid + i].shm_dtime = r.hour*10000+r.minute*100+r.second;
		shmpgtable.shm_segs[shmid + i].shm_lpid = process->pid;
		// cprintf("\ndt va: %d",((si+i)*PGSIZE)+HEAPLIMIT);
		clearmapping(process->pgdir,(char*)(((si+i)*PGSIZE)+HEAPLIMIT));
	}
	shmpgtable.shm_segs[shmid].shm_perm.mode |= SHM_DEST;
	release(&shmpgtable.lock);
	return 0;
}

// Helper function for sys_shmctl
int shmctlHelper(int shmid, int cmd, struct shmid_ds *buf){
	// for now permission on the segment is not checked

	int reqPages = 1;

	if(shmid < 0 || shmid > shmpgtable.lastShmSegIndex){
		return EINVAL;
	}

	if(shmpgtable.shm_segs[shmid].shm_perm.__key == -1){
		return EIDRM;
	}

	if(cmd == IPC_STAT){
		buf->shm_perm = shmpgtable.shm_segs[shmid].shm_perm;
		buf->shm_segsz = shmpgtable.shm_segs[shmid].shm_segsz;
		buf->shm_atime = shmpgtable.shm_segs[shmid].shm_atime;
		buf->shm_dtime = shmpgtable.shm_segs[shmid].shm_dtime;
		buf->shm_ctime = shmpgtable.shm_segs[shmid].shm_ctime;
		buf->shm_cpid = shmpgtable.shm_segs[shmid].shm_cpid;
		buf->shm_lpid = shmpgtable.shm_segs[shmid].shm_lpid;
		buf->shm_nattch = shmpgtable.shm_segs[shmid].shm_nattch;
		return 0;
	}
	else if(cmd == IPC_SET){
		// copy info in buf to the shmid_ds
		if (shmpgtable.shm_segs[shmid].shm_perm.mode & SHM_R){
			// return EACCES;
			return -1;
		}
		reqPages = buf->shm_segsz / PGSIZE;
		acquire(&shmpgtable.lock);
		for (int i = 0; i < reqPages; i++){
			shmpgtable.shm_segs[shmid + i].shm_perm = buf->shm_perm;
			shmpgtable.shm_segs[shmid + i].shm_segsz = buf->shm_segsz;
			shmpgtable.shm_segs[shmid + i].shm_atime = buf->shm_atime;
			shmpgtable.shm_segs[shmid + i].shm_dtime = buf->shm_dtime;
			shmpgtable.shm_segs[shmid + i].shm_ctime = buf->shm_ctime;
			shmpgtable.shm_segs[shmid + i].shm_cpid = buf->shm_cpid;
			shmpgtable.shm_segs[shmid + i].shm_lpid = buf->shm_lpid;
			shmpgtable.shm_segs[shmid + i].shm_nattch = buf->shm_nattch;
		}
		release(&shmpgtable.lock);
		return 0;
	}
	else if(cmd == IPC_RMID){
		// mark the segment to be destroyed
		// the segment will actually be destroyed only after the last process detaches it
		// the caller must ensure that the segment is eventually destoryed
		// (need to kfree the pages with the physical address stored in shmid_ds)
		reqPages = shmpgtable.shm_segs[shmid].shm_segsz / PGSIZE;
		for (int i = 0; i < reqPages; i++){
			shmpgtable.shm_segs[shmid + i].shm_perm.mode |= SHM_DEST;
		}
		return 0;
	}
	else if(cmd == IPC_INFO){
		// copy info in ipc_info to the buf
		// this buf will point to struct of type ipc_info, so cast is required
		// we're instead printing it
		cprintf("ipc_info.shmmax: %d\n", ipc_info.shmmax);
		cprintf("ipc_info.shmmin: %d\n", ipc_info.shmmin);
		cprintf("ipc_info.shmmni: %d\n", ipc_info.shmmni);
		cprintf("ipc_info.shmseg: %d\n", ipc_info.shmseg);
		cprintf("ipc_info.shmall: %d\n", ipc_info.shmall);

		return shmpgtable.lastShmSegIndex;
	}
	else if(cmd == SHM_INFO){
		// copy info in shm_info to the buf
		// this buf will point to struct of type shm_info, so cast is required
		// we're instead printing it
		cprintf("shm_info.used_ids: %d\n", shm_info.used_ids);
		cprintf("shm_info.shm_tot: %d\n", shm_info.shm_tot);

		return shmpgtable.lastShmSegIndex;
	}

	return 0;
}

void freeshmPages(int shmid){
	int reqPages = shmpgtable.shm_segs[shmid].shm_segsz / PGSIZE;

	for(int i = 0; i < reqPages; i++){
		shmpgtable.shm_segs[shmid + i].shm_perm.__key = -1;
		shmpgtable.shm_segs[shmid + i].shm_perm.mode = 0;
                shmpgtable.shm_segs[shmid + i].shm_segsz = 0;
                shmpgtable.shm_segs[shmid + i].shm_atime = -1;
                shmpgtable.shm_segs[shmid + i].shm_dtime = -1;
                shmpgtable.shm_segs[shmid + i].shm_ctime = -1;
                shmpgtable.shm_segs[shmid + i].shm_cpid = -1;
                shmpgtable.shm_segs[shmid + i].shm_lpid = -1;
                shmpgtable.shm_segs[shmid + i].shm_nattch = 0;
		kfree((char*)V2P(shmpgtable.shm_segs[shmid + i].pa));
		shmpgtable.shm_segs[shmid + i].pa = 0;
	}
}

// Helper function for sys_removeshm
int removeshmHelper(int shm_identifier, int flag){
	int shmid = shm_identifier;
	int i = 0;

	if(flag == 1){
		for(i = 0; i <= shmpgtable.lastShmSegIndex; i++){
			if(shmpgtable.shm_segs[i].shm_perm.__key == shm_identifier){
				shmid = i;
				cprintf("shmid: %d\n", shmid);
				break;
			}
		}
	}

	if(i == (shmpgtable.lastShmSegIndex + 1) || shmid  == (shmpgtable.lastShmSegIndex + 1)){
		cprintf("Invalid key or shmid!\n");
		return -1;
	}

	int reqPages = shmpgtable.shm_segs[shmid].shm_segsz / PGSIZE;
	for (int i = 0; i < reqPages; i++){
		shmpgtable.shm_segs[shmid + i].shm_perm.mode = SHM_DEST;
	}

	if(shmpgtable.shm_segs[shmid].shm_nattch == 0 && (shmpgtable.shm_segs[shmid].shm_perm.mode & SHM_DEST)){
		freeshmPages(shmid);
	}
	else{
		return -1;
	}

	return 0;
}
