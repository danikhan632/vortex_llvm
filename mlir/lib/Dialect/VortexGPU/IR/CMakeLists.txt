add_mlir_dialect_library(MLIRVortexGPUDialect
  VortexGPU.cpp
  Utils.cpp

  ADDITIONAL_HEADER_DIRS
  ${MLIR_MAIN_INCLUDE_DIR}/mlir/Dialect/VortexGPU

  DEPENDS
  MLIRVortexGPUOpsIncGen
  MLIRVortexGPUIntrinsicOpsIncGen

  LINK_LIBS PUBLIC
  MLIRIR
  MLIRLLVMDialect
  MLIRMemRefDialect
  MLIRSCFDialect
  MLIRSideEffectInterfaces
  MLIRVectorDialect
)
