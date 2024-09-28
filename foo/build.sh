cd ../build && clear && ninja -j 6




# cmake -G Ninja \
#       -DCMAKE_BUILD_TYPE=Debug \
#       -DLLVM_ENABLE_ASSERTIONS=ON \
#       -DLLVM_ENABLE_PROJECTS="mlir;llvm;clang" \
#       -DLLVM_TARGETS_TO_BUILD="host;RISCV" \
#       -DLLVM_ENABLE_DEBUG_INFO=FORCED \
#       -DLLVM_BUILD_LLVM_DYLIB=ON \
#       -DLLVM_LINK_LLVM_DYLIB=ON \
#       ../llvm