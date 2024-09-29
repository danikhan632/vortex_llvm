//===-- VortexGPU.td - VortexGPU dialect operation definitions ---*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines the basic operations for the VortexGPU dialect.
//
//===----------------------------------------------------------------------===//

#ifndef VORTEXGPU_OPS
#define VORTEXGPU_OPS

include "mlir/Interfaces/SideEffectInterfaces.td"
include "mlir/Dialect/LLVMIR/LLVMOpBase.td"

//===----------------------------------------------------------------------===//
// VortexGPU dialect definition
//===----------------------------------------------------------------------===//

def VortexGPU_Dialect : Dialect {
  let name = "vortex_gpu";
  let cppNamespace = "::mlir::vortex_gpu";
  let summary = "Basic dialect to target Arm SVE architectures";
  let description = [{
    This dialect contains the definitions necessary to target specific Arm SVE
    scalable vector operations.
  }];

  let dependentDialects = ["vector::VectorDialect"];
}

//===----------------------------------------------------------------------===//
// VortexGPU type definitions
//===----------------------------------------------------------------------===//

// def SVBool : ScalableVectorOfRankAndLengthAndType<
//   [1], [16], [I1]>;


#endif // VORTEXGPU_OPS
