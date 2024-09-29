add_mlir_dialect_library(MLIRVortexGPUTransforms
  LegalizeForLLVMExport.cpp
  # LegalizeVectorStorage.cpp

  DEPENDS
  MLIRVortexGPUConversionsIncGen
  MLIRVortexGPUPassIncGen

  LINK_LIBS PUBLIC
  MLIRVortexGPUDialect
  MLIRFuncDialect
  MLIRVectorDialect
  MLIRIR
  MLIRLLVMCommonConversion
  MLIRLLVMDialect
  )
