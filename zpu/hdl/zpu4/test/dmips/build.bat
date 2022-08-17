rem PATH=..\..\..\..\..\..\zpu-gcc-g++-multilib-win32\bin;%PATH%
PATH=..\..\..\..\..\..\install_exe\bin;%PATH%

dir ..\..\..\..\roadshow\roadshow\dhrystone\

rem zpu-elf-gcc -DTIME ..\..\..\..\roadshow\roadshow\dhrystone\dhry_*.c -O3 -Wl,--gc-sections -Wl,--relax -phi -o dmips.elf
zpu-elf-gcc -DTIME ..\..\..\..\roadshow\roadshow\dhrystone\dhry_1.c ..\..\..\..\roadshow\roadshow\dhrystone\dhry_2.c -O3 -Wl,--gc-sections -Wl,--relax -phi -o dmips.elf

zpu-elf-objdump --disassemble-all >dmips.dis dmips.elf
zpu-elf-objcopy -O binary dmips.elf dmips.bin

dir ..\..\..\..\sw\simulator\

java -classpath ..\..\..\..\sw\simulator\zpusim.jar com.zylin.zpu.simulator.tools.MakeRam dmips.bin >dmips.ram

