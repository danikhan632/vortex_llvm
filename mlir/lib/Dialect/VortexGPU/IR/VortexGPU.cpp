//===- VortexGPUDialect.cpp - MLIR VortexGPU dialect implementation -------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements the VortexGPU dialect and its operations.
//
//===----------------------------------------------------------------------===//

#include "mlir/Dialect/VortexGPU/IR/VortexGPU.h"
#include "mlir/Dialect/LLVMIR/LLVMTypes.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/TypeUtilities.h"
#include "llvm/ADT/TypeSwitch.h"

using namespace mlir;
using namespace mlir::vortex_gpu;

//===----------------------------------------------------------------------===//
// Tablegen Definitions
//===----------------------------------------------------------------------===//


#include "mlir/Dialect/VortexGPU/IR/VortexGPUDialect.cpp.inc"

#include "mlir/Dialect/VortexGPU/IR/VortexGPUEnums.cpp.inc"

#include "mlir/Dialect/VortexGPU/IR/VortexGPUOpInterfaces.cpp.inc"

#define GET_OP_CLASSES
#include "mlir/Dialect/VortexGPU/IR/VortexGPUOps.cpp.inc"

#define GET_OP_CLASSES
#include "mlir/Dialect/VortexGPU/IR/VortexGPUIntrinsicOps.cpp.inc"

#define GET_TYPEDEF_CLASSES
#include "mlir/Dialect/VortexGPU/IR/VortexGPUTypes.cpp.inc"

#define GET_ATTRDEF_CLASSES
#include "mlir/Dialect/VortexGPU/IR/VortexGPUAttrDefs.cpp.inc"

void VortexGPUDialect::initialize() {
  addAttributes<
#define GET_ATTRDEF_LIST
#include "mlir/Dialect/VortexGPU/IR/VortexGPUAttrDefs.cpp.inc"
      >();

  addOperations<
#define GET_OP_LIST
#include "mlir/Dialect/VortexGPU/IR/VortexGPUOps.cpp.inc"
      ,
#define GET_OP_LIST
#include "mlir/Dialect/VortexGPU/IR/VortexGPUIntrinsicOps.cpp.inc"
      >();
}
