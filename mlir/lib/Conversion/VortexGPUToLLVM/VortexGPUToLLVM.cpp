//===- VortexGPUToLLVM.cpp - Convert VortexGPU to LLVM dialect ------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
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
#include "mlir/Dialect/VortexGPU/IR/VortexGPU.h"
#include "mlir/Dialect/VortexGPU/Utils/Utils.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Dialect/Vector/IR/VectorOps.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/DialectConversion.h"

namespace mlir {
#define GEN_PASS_DEF_CONVERTVortexGPUTOLLVM
#include "mlir/Conversion/Passes.h.inc"
} // namespace mlir

using namespace mlir;



namespace {

struct ConvertVortexGPUToLLVMPass
    : public impl::ConvertVortexGPUToLLVMBase<ConvertVortexGPUToLLVMPass> {
  void runOnOperation() override {
    LLVMConversionTarget target(getContext());
    RewritePatternSet patterns(&getContext());
    LLVMTypeConverter converter(&getContext());
    configureVortexGPUToLLVMConversionLegality(target);
    populateVortexGPUToLLVMConversionPatterns(converter, patterns);

    if (failed(applyPartialConversion(getOperation(), target,
                                      std::move(patterns))))
      signalPassFailure();
  }
};

} // namespace

void mlir::configureVortexGPUToLLVMConversionLegality(ConversionTarget &target) {
  target.addIllegalDialect<vortex_gpu::VortexGPUDialect>();
  target.addLegalOp<
    >();
  target.addLegalDialect<arith::ArithDialect,
                         /* The following are used to lower tile spills/fills */
                         vector::VectorDialect, scf::SCFDialect,
                         memref::MemRefDialect>();
  target.addLegalOp<UnrealizedConversionCastOp>();
}

void mlir::populateVortexGPUToLLVMConversionPatterns(LLVMTypeConverter &converter,
                                                  RewritePatternSet &patterns) {
  converter.addConversion([&](VectorType type) -> std::optional<Type> {
    // There's no LLVM type for SME tiles, but after lowering to intrinsics all
    // SME vector types should be eliminated.

    return std::nullopt;
  });

  addVortexGPUConversionPatterns<>(patterns, converter);
}

std::unique_ptr<Pass> mlir::createConvertVortexGPUToLLVMPass() {
  return std::make_unique<ConvertVortexGPUToLLVMPass>();
}
