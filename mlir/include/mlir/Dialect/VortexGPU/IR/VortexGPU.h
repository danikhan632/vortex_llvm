//===- VortexGPUDialect.h - MLIR Dialect for Vortex GPU---------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file declares the Target dialect for VortexGPU in MLIR.
//
//===----------------------------------------------------------------------===//

#ifndef MLIR_DIALECT_VortexGPU_IR_VortexGPU_H
#define MLIR_DIALECT_VortexGPU_IR_VortexGPU_H

#include "mlir/Bytecode/BytecodeOpInterface.h"
#include "mlir/Dialect/VortexGPU/IR/VortexGPUEnums.h"
#include "mlir/Dialect/VortexGPU/Utils/Utils.h"
#include "mlir/Dialect/LLVMIR/LLVMTypes.h"
#include "mlir/Dialect/SCF/IR/SCF.h"
#include "mlir/Dialect/Vector/IR/VectorOps.h"
#include "mlir/IR/BuiltinTypes.h"
#include "mlir/IR/Dialect.h"
#include "mlir/IR/OpDefinition.h"
#include "mlir/Interfaces/SideEffectInterfaces.h"

namespace mlir::arm_sme {
static constexpr unsigned kInMemoryTileIdBase = 16;
#include "mlir/Dialect/VortexGPU/IR/VortexGPUOpInterfaces.h.inc"
} // namespace mlir::arm_sme

#define GET_ATTRDEF_CLASSES
#include "mlir/Dialect/VortexGPU/IR/VortexGPUAttrDefs.h.inc"

#include "mlir/Dialect/VortexGPU/IR/VortexGPUDialect.h.inc"

#define GET_OP_CLASSES
#include "mlir/Dialect/VortexGPU/IR/VortexGPUOps.h.inc"

#define GET_OP_CLASSES
#include "mlir/Dialect/VortexGPU/IR/VortexGPUIntrinsicOps.h.inc"

#endif // MLIR_DIALECT_VortexGPU_IR_VortexGPU_H
