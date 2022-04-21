kernel-img.bin : kernel_entry.asm kernel.c
	nasm kernel_entry.asm -f elf32 -o kernel_entry.o
	gcc -m32 -ffreestanding -nostdlib -lgcc -Werror -Wall -Wextra -c kernel.c -o kernel.o

	#i686-pc-cygwin-ld -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o --oformat binary
	i686-pc-cygwin-ld -o kernel-img.out -Ttext 0x1000 kernel_entry.o kernel.o
	objcopy -O binary -j .text kernel-img.out kernel-img.bin

	cp kernel-img.bin ../build/