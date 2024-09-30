//===-- Passes.td - VortexGPU pass definition file ------------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef MLIR_DIALECT_VORTEXGPU_TRANSFORMS_PASSES_TD
#define MLIR_DIALECT_VORTEXGPU_TRANSFORMS_PASSES_TD

include "mlir/Pass/PassBase.td"

//===----------------------------------------------------------------------===//
// VortexGPU Passes
//===----------------------------------------------------------------------===//

def VortexGPUOptimizePass : Pass<"vortex_gpu-optimize", "func::FuncOp"> {
  let summary = "Perform VortexGPU-specific optimizations";
  let description = [{
    This pass performs various VortexGPU-specific optimizations on functions
    containing VortexGPU operations. It can include transformations such as:
    - Operator fusion
    - Memory access optimization
    - VortexGPU-specific instruction scheduling
    - Any other optimizations specific to the VortexGPU architecture
  }];
  let constructor = "mlir::vortex_gpu::createVortexGPUOptimizePass()";
  let dependentDialects = ["mlir::vortex_gpu::VortexGPUDialect"];
}

#endif // MLIR_DIALECT_VORTEXGPU_TRANSFORMS_PASSES_TD