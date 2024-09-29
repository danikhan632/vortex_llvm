

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

} // namespace

// std::unique_ptr<Pass> mlir::vortex_gpu::createTemplatePass() {
//   return nullptr;
// }
