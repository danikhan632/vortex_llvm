set(LLVM_TARGET_DEFINITIONS Passes.td)
mlir_tablegen(Passes.h.inc -gen-pass-decls -name VortexGPU)
add_public_tablegen_target(MLIRVortexGPUPassIncGen)

add_mlir_doc(Passes VortexGPUPasses ./ -gen-pass-doc)
