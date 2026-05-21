### 64-Bit Linux Reverse Shell Payload (x86-64 Assembly)

This program generates a shellcode payload designed to execute `/bin/sh` on a target vulnerable software that runs on a Linux system. Using a `hexdump` you will notice the usefull section .text is free of nil bytes.

#### Compilation and Payload Extraction

You can compile the source file using the provided `makefile`. To extract the raw section .text bytes, strip the file metadata and elf64 segments using `objcopy`:

```bash
objcopy -O binary --only-section=.text ./<binary_name> <output_payload>
```

## NOTE
There will be created a script in the future that will make the strip automatically. This will be after I finish with the netowrk functionality of the reverse shell, till then stay tuned .... 

### THIS FOR EDUCATIONAL PURPOSES ONLY:
Iam doing the old way and not use AI for the code, I only to use it in order to understand things that I may miss as knowledge to achieve this. WHY ??!!! Cause It's fun !!!!