add_mlir_dialect_library(MLIRVortexGPUDialect
  VortexGPUDialect.cpp

  ADDITIONAL_HEADER_DIRS
  ${MLIR_MAIN_INCLUDE_DIR}/mlir/Dialect/VortexGPU

  DEPENDS
  MLIRVortexGPUIncGen

  LINK_LIBS PUBLIC
  MLIRIR
  MLIRLLVMDialect
  MLIRVectorDialect
  MLIRSideEffectInterfaces
  )
