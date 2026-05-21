bin=./ShellCode
file_o=./ShellCode.o
assemblyFile=./ShellCode.asm

${bin}: ${file_o}
	ld -o $@ $^ --no-pie

${file_o}: ${assemblyFile}
	nasm -f elf64 $^