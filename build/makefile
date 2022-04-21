#
C_SOURCES = $(wildcard ../kernel/*.c ../drivers/*.c)
HEADERS = $(wildcard ../kernel/*.h ../drivers/*.h)

OBJ = ${C_SOURCES:.c=.0}


# Default make target
all: os-img

# Run QEMU
run: all
	qemu-system-x86_64 os-img

os-img : loader32_withKernel.bin kernel-img.bin
	dd if=/dev/zero of=$@ bs=512 count=32
	dd if=loader32_withKernel.bin of=$@ bs=512 conv=notrunc
	dd if=kernel-img.bin of=$@ bs=512 seek=1 conv=notrunc

kernel-img.bin : ../kernel/kernel_entry.o ${OBJ}
	# $^ replaces target's dependancy files
	i686-pc-cygwin-ld -o kernel-img.out -Ttext 0x1000 $^
	# $@ replaces with target file
	objcopy -O binary -j .text kernel-img.out $@

kernel_entry.o : kernel_entry.asm
	nasm kernel_entry.asm -f elf32 -o kernel_entry.o

#Generic rule for building 'somefile.o' from 'somefile.c'
%.o : %.c ${HEADERS}
	gcc -m32 -ffreestanding -nostdlib -lgcc -Werror -Wall -Wextra -c $< -o $@
}


loader32_withKernel.bin : ../32bitProtectedMode/loader32_withKernel.asm
	# $< substitues first dependency 
	nasm $< -f bin -I '../32bitProtectedMode/' -o $@

kernel.dis : kernel.bin
	ndisasm -b 32 $< > $@

clean:
	rm -fr *.bin *.dis *.o os-img *.map
