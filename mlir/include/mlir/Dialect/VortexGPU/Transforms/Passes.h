//===- Passes.h - Pass Entrypoints ------------------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef MLIR_DIALECT_VORTEXGPU_TRANSFORMS_PASSES_H
#define MLIR_DIALECT_VORTEXGPU_TRANSFORMS_PASSES_H

#include "mlir/Conversion/LLVMCommon/TypeConverter.h"
#include "mlir/Pass/Pass.h"

namespace mlir::vortex_gpu {

//===----------------------------------------------------------------------===//
// Passes
//===----------------------------------------------------------------------===//

std::unique_ptr<Pass> createVortexGPUOptimizePass();

//===----------------------------------------------------------------------===//
// Registration
//===----------------------------------------------------------------------===//

/// Generate the code for registering passes.
#define GEN_PASS_REGISTRATION
#include "mlir/Dialect/VortexGPU/Transforms/Passes.h.inc"

} // namespace mlir::vortex_gpu

#endif // MLIR_DIALECT_VORTEXGPU_TRANSFORMS_PASSES_H