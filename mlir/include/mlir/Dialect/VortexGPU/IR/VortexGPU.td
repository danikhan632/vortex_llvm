//===-- VortexGPU.td - VortexGPU dialect definitions ------------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file contains the definition of the VortexGPU dialect as well as some
// shared definitions.
//
//===----------------------------------------------------------------------===//

#ifndef VortexGPU
#define VortexGPU


include "mlir/IR/DialectBase.td"
include "mlir/Dialect/LLVMIR/LLVMOpBase.td"

//===----------------------------------------------------------------------===//
// VortexGPU Dialect
//===----------------------------------------------------------------------===//

def VortexGPU_Dialect : Dialect {
  let name = "vortex_gpu";
  let cppNamespace = "::mlir::vortex_gpu";
  let summary = "Basic dialect to target Arm SME architectures";
  let description = [{

  }];
  let dependentDialects = ["scf::SCFDialect", "vector::VectorDialect",
                           "memref::MemRefDialect"];
  let useDefaultAttributePrinterParser = 1;
}

//===----------------------------------------------------------------------===//
// VortexGPU type definitions
//===----------------------------------------------------------------------===//

// FIXME: This allows types that are not SVE vectors, e.g. vector<[16]xi128>.


#endif // VortexGPU
