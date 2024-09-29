//===-- VortexGPUOps.td - VortexGPU dialect operation definitions *- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines the VortexGPU dialect ops. It also defines custom attributes
// and types that are used to define the Ops
//
//===----------------------------------------------------------------------===//

#ifndef VortexGPU_OPS
#define VortexGPU_OPS

include "VortexGPU.td"
include "mlir/IR/EnumAttr.td"
include "mlir/IR/OpBase.td"
include "mlir/Interfaces/SideEffectInterfaces.td"
include "mlir/Dialect/LLVMIR/LLVMOpBase.td"
include "mlir/Interfaces/InferTypeOpInterface.td"

//===----------------------------------------------------------------------===//
// VortexGPU op interfaces
//===----------------------------------------------------------------------===//


//===----------------------------------------------------------------------===//
// VortexGPU op definitions
//===----------------------------------------------------------------------===//

class VortexGPU_Op<string mnemonic, list<Trait> traits = []> :
  Op<VortexGPU_Dialect, mnemonic, traits> {}





#endif // VortexGPU_OPS
