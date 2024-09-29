clear
PWD=$(dirname "$PWD")



  $PWD/build/bin/llc \
  -march=riscv32 \
  -mattr=+m,+a,+f,+vortex,+zicond \
  -mcpu=generic-rv32 \
  -mtriple=riscv32-unknown-elf \
  -filetype=asm \
  -O3 \
  kernel.ll -o kernel.s



$PWD/build/bin/llvm-mc -triple=riscv32-unknown-elf  -mattr=+m,+a,+f,+vortex,+zicond  -filetype=obj  kernel.s  -o kernel.o


$PWD/build/bin/llvm-objdump  -d  -M no-aliases  --mattr=+m,+a,+f,+vortex,+zicond  kernel.o > kernel_compiled.s