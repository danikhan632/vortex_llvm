PWD=$(dirname "$PWD")

$PWD/build/bin/llc -O0 -march=riscv32 -mcpu=generic-rv32 -mattr=+m,+a,+f,+vortex $PWD/foo/kernel.ll -o $PWD/foo/kernel.s
