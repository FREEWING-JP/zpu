zpu-elf-gcc -O3 -phi ./zputest.c -o zputest.elf -Wl,--relax -Wl,--gc-sections -g
zpu-elf-objdump --disassemble-all >zputest.dis zputest.elf
zpu-elf-objcopy -O binary zputest.elf zputest.bin
java -classpath ../../../../sw/simulator/zpusim.jar com.zylin.zpu.simulator.tools.MakeRam zputest.bin >zputest.ram
