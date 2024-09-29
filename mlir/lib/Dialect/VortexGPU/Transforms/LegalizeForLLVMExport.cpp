//===- LegalizeForLLVMExport.cpp - Prepare VortexGPU for LLVM translation ----===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "mlir/Conversion/LLVMCommon/ConversionTarget.h"
#include "mlir/Conversion/LLVMCommon/Pattern.h"
#include "mlir/Dialect/VortexGPU/IR/VortexGPUDialect.h"
#include "mlir/Dialect/VortexGPU/Transforms/Transforms.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/Utils/IndexingUtils.h"
#include "mlir/Dialect/Vector/IR/VectorOps.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/PatternMatch.h"

using namespace mlir;
using namespace mlir::vortex_gpu;



namespace {



} // namespace

/// Populate the given list with patterns that convert from VortexGPU to LLVM.
void mlir::populateVortexGPULegalizeForLLVMExportPatterns(
    LLVMTypeConverter &converter, RewritePatternSet &patterns) {
  // Populate conversion patterns

  // clang-format off

  // clang-format on
}


