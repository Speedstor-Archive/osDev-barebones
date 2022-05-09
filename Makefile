
boot:
	i686-elf-as boot.s -o boot.o


kernel:
	i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

kernel-cpp:
	i686-elf-g++ -c kernel.c++ -o kernel.o -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti


linker:
	i686-elf-gcc -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc


all: boot kernel linker
