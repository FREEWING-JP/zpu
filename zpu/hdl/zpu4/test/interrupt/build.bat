PATH=..\..\..\..\..\..\install_exe\bin;%PATH%

zpu-elf-gcc -O3 -phi .\int.c -o int.elf -Wl,--relax -Wl,--gc-sections  -g
zpu-elf-objdump --disassemble-all >int.dis int.elf
zpu-elf-objcopy -O binary int.elf int.bin
java -classpath ..\..\..\..\sw\simulator\zpusim.jar com.zylin.zpu.simulator.tools.MakeRam int.bin >int.ram
