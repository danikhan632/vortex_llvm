add_mlir_dialect(VortexGPU vortex_gpu VortexGPU)


# Generate declarations and definitions of VortexGPU Ops
set(LLVM_TARGET_DEFINITIONS VortexGPUOps.td)
mlir_tablegen(VortexGPUOps.h.inc -gen-op-decls)
mlir_tablegen(VortexGPUOps.cpp.inc -gen-op-defs)
mlir_tablegen(VortexGPUEnums.h.inc -gen-enum-decls)
mlir_tablegen(VortexGPUEnums.cpp.inc -gen-enum-defs)
mlir_tablegen(VortexGPUAttrDefs.h.inc -gen-attrdef-decls -attrdefs-dialect=vortex_gpu)
mlir_tablegen(VortexGPUAttrDefs.cpp.inc -gen-attrdef-defs -attrdefs-dialect=vortex_gpu)
add_public_tablegen_target(MLIRVortexGPUOpsIncGen)

# Generate LLVM IR Conversions
set(LLVM_TARGET_DEFINITIONS VortexGPUOps.td)
mlir_tablegen(VortexGPUOpsConversions.inc -gen-llvmir-conversions)
add_public_tablegen_target(MLIRVortexGPUConversionsIncGen)

# Generate op interface declarations and definitions
set(LLVM_TARGET_DEFINITIONS VortexGPUOps.td)
mlir_tablegen(VortexGPUOpInterfaces.h.inc -gen-op-interface-decls)
mlir_tablegen(VortexGPUOpInterfaces.cpp.inc -gen-op-interface-defs)
add_public_tablegen_target(MLIRVortexGPUOpInterfaces)

# Generate declarations and definitions of VortexGPU intrinsic Ops
set(LLVM_TARGET_DEFINITIONS VortexGPUIntrinsicOps.td)
mlir_tablegen(VortexGPUIntrinsicOps.h.inc -gen-op-decls)
mlir_tablegen(VortexGPUIntrinsicOps.cpp.inc -gen-op-defs)
mlir_tablegen(VortexGPUIntrinsicConversions.inc -gen-llvmir-conversions)
add_public_tablegen_target(MLIRVortexGPUIntrinsicOpsIncGen)

# Generate the docs
add_mlir_doc(VortexGPUOps VortexGPUOps Dialects/ -gen-op-doc)
add_mlir_doc(VortexGPUIntrinsicOps VortexGPUIntrinsicOps Dialects/ -gen-op-doc)
