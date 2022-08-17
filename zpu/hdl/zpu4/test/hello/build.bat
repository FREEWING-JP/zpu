rem PATH=..\..\..\..\..\..\zpu-gcc-g++-multilib-win32\bin;%PATH%
PATH=..\..\..\..\..\..\install_exe\bin;%PATH%

zpu-elf-gcc -O3 -phi ./hello.c -o hello.elf -Wl,--relax -Wl,--gc-sections -g -lm
zpu-elf-objdump --disassemble-all >hello.dis hello.elf
zpu-elf-objcopy -O binary hello.elf hello.bin

dir ..\..\..\..\sw\simulator\

java -classpath ..\..\..\..\sw\simulator\zpusim.jar com.zylin.zpu.simulator.tools.MakeRam hello.bin >hello.ram

