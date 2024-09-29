//===- VortexGPUDialect.h - MLIR Dialect for Arm SVE ---------------*- C++ -*-===//
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

#ifndef MLIR_DIALECT_VORTEXGPU_VORTEXGPUDIALECT_H
#define MLIR_DIALECT_VORTEXGPU_VORTEXGPUDIALECT_H

#include "mlir/Bytecode/BytecodeOpInterface.h"
#include "mlir/IR/BuiltinTypes.h"
#include "mlir/IR/Dialect.h"
#include "mlir/IR/OpDefinition.h"
#include "mlir/Interfaces/SideEffectInterfaces.h"

#include "mlir/Dialect/VortexGPU/IR/VortexGPUDialect.h.inc"

#define GET_OP_CLASSES
#include "mlir/Dialect/VortexGPU/IR/VortexGPU.h.inc"

#endif // MLIR_DIALECT_VORTEXGPU_VORTEXGPUDIALECT_H
