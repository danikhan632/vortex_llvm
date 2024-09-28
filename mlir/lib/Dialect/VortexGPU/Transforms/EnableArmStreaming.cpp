

#include "mlir/Dialect/VortexGPU/IR/VortexGPU.h"
#include "mlir/Dialect/VortexGPU/Transforms/Passes.h"
#include "mlir/Dialect/VortexGPU/Transforms/PassesEnums.cpp.inc"

#include "mlir/Dialect/Func/IR/FuncOps.h"

#define DEBUG_TYPE "enable-arm-streaming"

namespace mlir {
namespace vortex_gpu {
#define GEN_PASS_DEF_ENABLEARMSTREAMING
#include "mlir/Dialect/VortexGPU/Transforms/Passes.h.inc"
} // namespace vortex_gpu
} // namespace mlir

using namespace mlir;
using namespace mlir::vortex_gpu;
namespace {

constexpr StringLiteral
    kEnableArmStreamingIgnoreAttr("enable_arm_streaming_ignore");

struct EnableArmStreamingPass
    : public vortex_gpu::impl::EnableArmStreamingBase<EnableArmStreamingPass> {
  EnableArmStreamingPass(ArmStreamingMode streamingMode, ArmZaMode zaMode,
                         bool onlyIfRequiredByOps) {
    this->streamingMode = streamingMode;
    this->zaMode = zaMode;
    this->onlyIfRequiredByOps = onlyIfRequiredByOps;
  }
  void runOnOperation() override {
    auto op = getOperation();

    if (onlyIfRequiredByOps) {
      bool foundTileOp = false;
      op.walk([&](Operation *op) {
        if (llvm::isa<VortexGPUTileOpInterface>(op)) {
          foundTileOp = true;
          return WalkResult::interrupt();
        }
        return WalkResult::advance();
      });
      if (!foundTileOp)
        return;
    }

    if (op->getAttr(kEnableArmStreamingIgnoreAttr) ||
        streamingMode == ArmStreamingMode::Disabled)
      return;

    auto unitAttr = UnitAttr::get(&getContext());

    op->setAttr(stringifyArmStreamingMode(streamingMode), unitAttr);

    // The pass currently only supports enabling ZA when in streaming-mode, but
    // ZA can be accessed by the SME LDR, STR and ZERO instructions when not in
    // streaming-mode (see section B1.1.1, IDGNQM of spec [1]). It may be worth
    // supporting this later.
    if (zaMode != ArmZaMode::Disabled)
      op->setAttr(stringifyArmZaMode(zaMode), unitAttr);
  }
};
} // namespace

std::unique_ptr<Pass> mlir::vortex_gpu::createEnableArmStreamingPass(
    const ArmStreamingMode streamingMode, const ArmZaMode zaMode,
    bool onlyIfRequiredByOps) {
  return std::make_unique<EnableArmStreamingPass>(streamingMode, zaMode,
                                                  onlyIfRequiredByOps);
}
