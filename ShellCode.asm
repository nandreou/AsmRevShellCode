section .text

global _start
_start:

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