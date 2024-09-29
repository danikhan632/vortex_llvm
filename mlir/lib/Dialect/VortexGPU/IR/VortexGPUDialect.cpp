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

#include "mlir/Dialect/VortexGPU/IR/VortexGPUDialect.h"
#include "mlir/Dialect/LLVMIR/LLVMTypes.h"
#include "mlir/Dialect/Vector/IR/VectorOps.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/IR/TypeUtilities.h"
#include "llvm/ADT/TypeSwitch.h"

using namespace mlir;
using namespace mlir::vortex_gpu;

//===----------------------------------------------------------------------===//
// ScalableVector versions of general helpers for comparison ops
//===----------------------------------------------------------------------===//

/// Return the scalable vector of the same shape and containing i1.
static Type getI1SameShape(Type type) {
  auto i1Type = IntegerType::get(type.getContext(), 1);
  if (auto sVectorType = llvm::dyn_cast<VectorType>(type))
    return VectorType::get(sVectorType.getShape(), i1Type,
                           sVectorType.getScalableDims());
  return nullptr;
}

//===----------------------------------------------------------------------===//
// Tablegen Definitions
//===----------------------------------------------------------------------===//

#include "mlir/Dialect/VortexGPU/IR/VortexGPUDialect.cpp.inc"

#define GET_OP_CLASSES
#include "mlir/Dialect/VortexGPU/IR/VortexGPU.cpp.inc"

#define GET_TYPEDEF_CLASSES
#include "mlir/Dialect/VortexGPU/IR/VortexGPUTypes.cpp.inc"

void VortexGPUDialect::initialize() {
  addOperations<
#define GET_OP_LIST
#include "mlir/Dialect/VortexGPU/IR/VortexGPU.cpp.inc"
      >();
}
