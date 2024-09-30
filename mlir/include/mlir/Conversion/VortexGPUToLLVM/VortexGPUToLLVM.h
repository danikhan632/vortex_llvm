//===- VortexGPUPasses.h - VortexGPU optimization passes --------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file declares the optimization passes for the VortexGPU dialect.
//
//===----------------------------------------------------------------------===//

#ifndef MLIR_DIALECT_VORTEXGPU_TRANSFORMS_PASSES_H
#define MLIR_DIALECT_VORTEXGPU_TRANSFORMS_PASSES_H

#include "mlir/Pass/Pass.h"

namespace mlir {
namespace vortex_gpu {

#define GEN_PASS_DECL_VORTEXGPUOPTIMIZEPASS
#include "mlir/Dialect/VortexGPU/Transforms/Passes.h.inc"

/// Creates a pass to perform VortexGPU-specific optimizations.
std::unique_ptr<Pass> createVortexGPUOptimizePass();

/// Generate the code for registering passes.
#define GEN_PASS_REGISTRATION
#include "mlir/Dialect/VortexGPU/Transforms/Passes.h.inc"

} // namespace vortexgpu
} // namespace mlir

#endif // MLIR_DIALECT_VORTEXGPU_TRANSFORMS_PASSES_H