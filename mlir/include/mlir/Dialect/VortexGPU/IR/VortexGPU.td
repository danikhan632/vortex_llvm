//===-- VortexGPU.td - VortexGPU dialect operation definitions -*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines the VortexGPU dialect and its operations.
//
//===----------------------------------------------------------------------===//

#ifndef VORTEXGPU_OPS
#define VORTEXGPU_OPS

include "mlir/IR/OpBase.td"
include "mlir/Interfaces/SideEffectInterfaces.td"
include "mlir/Dialect/LLVMIR/LLVMOpBase.td"

//===----------------------------------------------------------------------===//
// VortexGPU dialect definition
//===----------------------------------------------------------------------===//

def VortexGPU_Dialect : Dialect {
  let name = "vortex_gpu";
  let cppNamespace = "::mlir::vortex_gpu";
  let summary = "A dialect for Vortex GPU operations.";
  let description = [{
    This dialect contains operations specific to the Vortex GPU architecture.
  }];
}

//===----------------------------------------------------------------------===//
// Base class for VortexGPU dialect operations
//===----------------------------------------------------------------------===//

class VortexGPU_Op<string mnemonic, list<Trait> traits = []> :
    Op<VortexGPU_Dialect, mnemonic, traits>;

//===----------------------------------------------------------------------===//
// VortexGPU Operations
//===----------------------------------------------------------------------===//

def VortexGPU_LocalLWOp : VortexGPU_Op<"local_lw", [MemoryEffects<[MemRead]>]> {
  let summary = "Local Load Word operation";
  let description = [{
    Loads a 32-bit word from local memory.
  }];

  let arguments = (ins I32:$rs1, I32Attr:$imm12);
  let results = (outs I32:$rd);

  let assemblyFormat = "$rs1 `,` $imm12 attr-dict `:` type($rs1) `->` type($rd)";
}

def VortexGPU_LocalSWOp : VortexGPU_Op<"local_sw", [MemoryEffects<[MemWrite]>]> {
  let summary = "Local Store Word operation";
  let description = [{
    Stores a 32-bit word to local memory.
  }];

  let arguments = (ins I32:$rs2, I32:$rs1, I32Attr:$imm12);
  let results = (outs);

  let assemblyFormat = "$rs2 `,` $rs1 `,` $imm12 attr-dict `:` type($rs2) `,` type($rs1)";
}

def VortexGPU_BarrierOp : VortexGPU_Op<"barrier", []> {
  let summary = "Barrier operation";
  let description = [{
    Synchronizes all work items.
  }];

  let arguments = (ins I32:$rs1, I32:$rs2);
  let results = (outs);

  let assemblyFormat = "$rs1 `,` $rs2 attr-dict `:` type($rs1) `,` type($rs2)";
}

def VortexGPU_RasterOp : VortexGPU_Op<"rast", []> {
  let summary = "Rasterization operation";
  let description = [{
    Performs rasterization in the GPU pipeline.
  }];

  let arguments = (ins);
  let results = (outs I32:$rd);

  let assemblyFormat = "attr-dict `:` type($rd)";
}

def VortexGPU_TexOp : VortexGPU_Op<"tex", [MemoryEffects<[MemRead]>]> {
  let summary = "Texture Fetch operation";
  let description = [{
    Fetches texture data from memory.
  }];

  let arguments = (ins I32:$rs1, I32:$rs2, I32:$rs3);
  let results = (outs I32:$rd);

  let assemblyFormat = "$rs1 `,` $rs2 `,` $rs3 attr-dict `:` type($rs1) `,` type($rs2) `,` type($rs3) `->` type($rd)";
}

def VortexGPU_ROPOp : VortexGPU_Op<"rop", [MemoryEffects<[MemWrite]>]> {
  let summary = "Render Output operation";
  let description = [{
    Performs render output processing.
  }];

  let arguments = (ins I32:$rs1, I32:$rs2, I32:$rs3);
  let results = (outs);

  let assemblyFormat = "$rs1 `,` $rs2 `,` $rs3 attr-dict `:` type($rs1) `,` type($rs2) `,` type($rs3)";
}

#endif // VORTEXGPU_OPS