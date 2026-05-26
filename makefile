dump=./dump.txt
ShellCode=./ShellCode.bin
bin=./ShellCode
file_o=./ShellCode.o
assemblyFile=./ShellCode.asm

all: ${dump}
binary: ${bin}

${dump}: ${ShellCode}
	hexdump -C $^ > $@

${ShellCode}: ${bin}
	objcopy -O binary --only-section=.text $^ $@

${bin}: ${file_o}
	ld -o $@ $^ --no-pie

${file_o}: ${assemblyFile}
	nasm -f elf64 $^