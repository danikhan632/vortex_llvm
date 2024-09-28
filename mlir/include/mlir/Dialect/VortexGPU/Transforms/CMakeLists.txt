set(LLVM_TARGET_DEFINITIONS Passes.td)
mlir_tablegen(Passes.h.inc -gen-pass-decls -name VortexGPU)
mlir_tablegen(PassesEnums.h.inc -gen-enum-decls)
mlir_tablegen(PassesEnums.cpp.inc -gen-enum-defs)
add_public_tablegen_target(MLIRVortexGPUTransformsIncGen)
add_dependencies(mlir-headers MLIRVortexGPUTransformsIncGen)

add_mlir_doc(Passes VortexGPUPasses ./ -gen-pass-doc)

