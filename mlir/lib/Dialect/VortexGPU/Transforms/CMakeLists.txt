add_mlir_dialect_library(MLIRVortexGPUTransforms
  EnableArmStreaming.cpp
  TileAllocation.cpp

  ADDITIONAL_HEADER_DIRS
  ${MLIR_MAIN_INCLUDE_DIR}/mlir/Dialect/VortexGPU/Transforms

  DEPENDS
  MLIRVortexGPUTransformsIncGen

  LINK_LIBS PUBLIC
  MLIRVortexGPUDialect
  MLIRFuncDialect
  MLIRLLVMCommonConversion
  MLIRVectorDialect
  MLIRSCFDialect
  MLIRPass
  )
