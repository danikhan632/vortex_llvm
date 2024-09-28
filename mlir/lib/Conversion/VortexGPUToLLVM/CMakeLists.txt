add_mlir_conversion_library(MLIRVortexGPUToLLVM
  VortexGPUToLLVM.cpp

  ADDITIONAL_HEADER_DIRS
  ${MLIR_MAIN_INCLUDE_DIR}/mlir/Conversion/VortexGPUToLLVM

  
  DEPENDS
  MLIRConversionPassIncGen

  LINK_LIBS PUBLIC
  MLIRVortexGPUTransforms
  MLIRVortexGPUDialect
  MLIRTransforms
  MLIRLLVMCommonConversion
  MLIRLLVMDialect)
