//===- VortexGPUToLLVM.cpp - Convert VortexGPU to LLVM dialect ------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
//
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements lowering of VortexGPU operations to LLVM intrinsics.
//
//===----------------------------------------------------------------------===//

#include "mlir/Conversion/VortexGPUToLLVM/VortexGPUToLLVM.h"

#include "mlir/Conversion/LLVMCommon/ConversionTarget.h"
#include "mlir/Conversion/LLVMCommon/Pattern.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/VortexGPU/IR/VortexGPUDialect.h"

#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Dialect/Vector/IR/VectorOps.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/DialectConversion.h"

#include "mlir/Dialect/VortexGPU/Transforms/Passes.h"
#include "mlir/Dialect/VortexGPU/IR/VortexGPUDialect.h"
#include "mlir/Pass/Pass.h"

using namespace mlir;

namespace mlir {
namespace vortex_gpu {

#define GEN_PASS_DEF_VORTEXGPUOPTIMIZEPASS
#include "mlir/Dialect/VortexGPU/Transforms/Passes.h.inc"

struct VortexGPUOptimizePass
    : public impl::VortexGPUOptimizePassBase<VortexGPUOptimizePass> {
  void runOnOperation() override {
    // Implement your VortexGPU optimization logic here
  }
};

std::unique_ptr<Pass> createVortexGPUOptimizePass() {
  return std::make_unique<VortexGPUOptimizePass>();
}

} // namespace vortexgpu
} // namespace mlir