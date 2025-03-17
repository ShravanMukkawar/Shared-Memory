#include <stdio.h>
#include <stdlib.h>
#include <sys/shm.h>
#include <string.h>

int create_memory(int key, int size) {
	int idx = shmget(key, size, IPC_CREAT | 0666);
	if (idx == -1) {
		perror("shmget");
		return -1;
	}
	return idx;
}

void attachfile(int idx) {
	FILE *file = fopen("shravan.txt", "r");
	if (file == NULL) {
		perror("fopen");
		return;
	}

	char *shm = shmat(idx, NULL, 0);
	if (shm == (char *)-1) {
		perror("shmat");
		fclose(file);
		return;
	}

	char buffer[1024];
	size_t bytes = fread(buffer, sizeof(char), 1023, file);
	buffer[bytes] = '\0';
	fclose(file);

	strncpy(shm, buffer, 1024);
	printf("Data copied to shared memory: %s\n", shm);
	if (shmdt(shm) == -1) {
		perror("shmdt");
	}
}

int main() {
	int idx = create_memory(119, 1024);
	if (idx == -1) {
		return 1;
	}

	printf("Memory Segment Key is: %d\n", idx);
	attachfile(idx);

	return 0;
}
