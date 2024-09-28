//===-- Passes.td - VortexGPU pass definition file ------------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef MLIR_DIALECT_VortexGPU_TRANSFORMS_PASSES_TD
#define MLIR_DIALECT_VortexGPU_TRANSFORMS_PASSES_TD

include "mlir/Pass/PassBase.td"
include "mlir/IR/EnumAttr.td"

def ArmStreamingMode : I32EnumAttr<"ArmStreamingMode", "Armv9 Streaming SVE mode",
    [
      I32EnumAttrCase<"Disabled", 0, "disabled">,
      // Streaming: Streaming-mode is part of the function interface (ABI).
      I32EnumAttrCase<"Streaming", 1, "arm_streaming">,
      // StreamingLocally: PSTATE.SM is kept internal and the callee manages it
      // on entry/exit.
      I32EnumAttrCase<"StreamingLocally", 2, "arm_locally_streaming">,
      // StreamingCompatible: the function may be entered in either
      // non-streaming mode (PSTATE.SM=0) or in streaming mode (PSTATE.SM=1)
      I32EnumAttrCase<"StreamingCompatible", 3, "arm_streaming_compatible">,
    ]>{
  let cppNamespace = "mlir::vortex_gpu";
  let genSpecializedAttr = 0;
}


def ArmZaMode : I32EnumAttr<"ArmZaMode", "Armv9 ZA storage mode",
    [
      I32EnumAttrCase<"Disabled", 0, "disabled">,
      // A function's ZA state is created on entry and destroyed on exit.
      I32EnumAttrCase<"NewZA", 1, "arm_new_za">,
      // A function that preserves ZA state.
      I32EnumAttrCase<"PreservesZA", 2, "arm_preserves_za">,
      // A function that uses ZA state as input and/or output
      I32EnumAttrCase<"SharedZA", 3, "arm_shared_za">,
    ]>{
  let cppNamespace = "mlir::vortex_gpu";
  let genSpecializedAttr = 0;
}

def EnableArmStreaming
    : Pass<"enable-arm-streaming", "mlir::func::FuncOp"> {
  let summary = "Enable Armv9 Streaming SVE mode";
  let description = [{
    Enables the Armv9 Streaming SVE mode [1] for func.func ops by annotating
    them with attributes. See options for more details.

    [1] https://developer.arm.com/documentation/ddi0616/aa
  }];
  let constructor = "mlir::vortex_gpu::createEnableArmStreamingPass()";
  let options = [
    Option<"streamingMode", "streaming-mode", "mlir::vortex_gpu::ArmStreamingMode",
          /*default=*/"mlir::vortex_gpu::ArmStreamingMode::Streaming",
          "Select how streaming-mode is managed at the function-level.",
          [{::llvm::cl::values(
                clEnumValN(mlir::vortex_gpu::ArmStreamingMode::Disabled,
                           "disabled", "Streaming mode is disabled."),
                clEnumValN(mlir::vortex_gpu::ArmStreamingMode::Streaming,
                           "streaming",
                           "Streaming mode is part of the function interface "
                           "(ABI), caller manages PSTATE.SM on entry/exit."),
                clEnumValN(mlir::vortex_gpu::ArmStreamingMode::StreamingLocally,
                           "streaming-locally",
                           "Streaming mode is internal to the function, callee "
                           "manages PSTATE.SM on entry/exit."),
                clEnumValN(mlir::vortex_gpu::ArmStreamingMode::StreamingCompatible,
                           "streaming-compatible",
                           "Function supports both streaming and non-streaming "
                           "modes.")
          )}]>,
    Option<"zaMode", "za-mode", "mlir::vortex_gpu::ArmZaMode",
           /*default=*/"mlir::vortex_gpu::ArmZaMode::Disabled",
           "Select how ZA-storage is managed at the function-level.",
           [{::llvm::cl::values(
                 clEnumValN(mlir::vortex_gpu::ArmZaMode::Disabled,
                            "disabled", "ZA storage is disabled."),
                 clEnumValN(mlir::vortex_gpu::ArmZaMode::NewZA,
                            "new-za",
                            "The function has ZA state. The ZA state is "
                            "created on entry and destroyed on exit."),
                 clEnumValN(mlir::vortex_gpu::ArmZaMode::PreservesZA,
                            "preserves-za",
                            "The function preserves ZA state. The ZA state is "
                            "saved on entry and restored on exit."),
                 clEnumValN(mlir::vortex_gpu::ArmZaMode::SharedZA,
                            "shared-za",
                            "The function uses ZA state. The ZA state may "
                            "be used for input and/or output.")
           )}]>,
    Option<"onlyIfRequiredByOps", "only-if-required-by-ops", "bool",
           /*default=*/"false",
           "Only apply the selected streaming/ZA modes if the function "
           " contains ops that require them.">
  ];
  let dependentDialects = ["func::FuncDialect"];
}

def TileAllocation
    : Pass<"allocate-arm-sme-tiles", "mlir::func::FuncOp"> {
  let summary = "Allocate SME tiles";
  let description = [{
    This pass does tile allocation for SME "virtual tiles". It is run at the
    'func.func' op level, and assigns tile IDs (via an attribute) to all ops
    that implement the `VortexGPUTileOpInterface`. An error will be emitted when
    there's no tiles left.
  }];
  let constructor = "mlir::vortex_gpu::createTileAllocationPass()";
  let dependentDialects = ["func::FuncDialect"];
}

#endif // MLIR_DIALECT_VortexGPU_TRANSFORMS_PASSES_TD
