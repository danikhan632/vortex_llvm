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
