add_mlir_dialect(VortexGPU vortex_gpu VortexGPU)
add_mlir_doc(VortexGPU VortexGPU Dialects/ -gen-dialect-doc -dialect=vortex_gpu)

set(LLVM_TARGET_DEFINITIONS VortexGPU.td)
mlir_tablegen(VortexGPUConversions.inc -gen-llvmir-conversions)
add_public_tablegen_target(MLIRVortexGPUConversionsIncGen)
