PATH=..\..\..\..\..\install_exe\bin;%PATH%

zpu-elf-gcc -phi -DTIME dhry_1.c dhry_2.c -O3 -Wl,--relax -Wl,--gc-sections -o dhrystone.elf 
zpu-elf-size *.elf
zpu-elf-objcopy -O binary dhrystone.elf dhrystone.bin
rem // sh ../build/makefirmware.sh dhrystone.bin dhrystone.zpu

dir ..\..\..\sw\simulator\

java -classpath ..\..\..\sw\simulator\zpusim.jar com.zylin.zpu.simulator.tools.MakeRam dhrystone.bin >dhrystone.ram

