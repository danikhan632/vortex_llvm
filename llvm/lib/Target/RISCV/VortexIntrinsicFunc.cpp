#include "RISCV.h"
#include "RISCVSubtarget.h"

// #include "llvm-c/Core.h"

#include "RISCV.h"
#include "RISCVSubtarget.h"
#include "llvm/ADT/APInt.h"
#include "llvm/CodeGen/TargetPassConfig.h"
#include "llvm/CodeGen/ValueTypes.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/IR/IntrinsicsRISCV.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Operator.h"
#include "llvm/IR/Value.h"
#include "llvm/InitializePasses.h"
#include "llvm/Pass.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include <iostream>
#include <map>
#include <string>

#include <iostream>
#include <set>
#include <string>
#include <vector>

using namespace llvm;
// using namespace vortex;

#define DEBUG_TYPE "vortex-intrinsic-lowering"

void printIR(llvm::Module *module_) {
  std::string module_str;
  llvm::raw_string_ostream ostream{module_str};
  module_->print(ostream, nullptr, false);
  std::cout << module_str << std::endl;
}

class VortexIntrinsicFuncLowering final : public ModulePass {

  bool runOnModule(Module &M) override;
  bool Modified;

public:
  static char ID;
  VortexIntrinsicFuncLowering();
};

namespace llvm {

void initializeVortexIntrinsicFuncLoweringPass(PassRegistry &);
ModulePass *createVortexIntrinsicFuncLoweringPass() {
  return new VortexIntrinsicFuncLowering();
}
} // End namespace llvm

INITIALIZE_PASS(VortexIntrinsicFuncLowering, DEBUG_TYPE,
                "Fix function bitcasts for VortexGPU", false, false)

char VortexIntrinsicFuncLowering::ID = 0;

VortexIntrinsicFuncLowering::VortexIntrinsicFuncLowering() : ModulePass(ID) {
  initializeVortexIntrinsicFuncLoweringPass(*PassRegistry::getPassRegistry());
}

void printColored(const std::string &text, const std::string &color) {
  static const std::map<std::string, std::string> colorCodes = {
      {"black", "\033[30m"},  {"red", "\033[31m"},  {"green", "\033[32m"},
      {"yellow", "\033[33m"}, {"blue", "\033[34m"}, {"magenta", "\033[35m"},
      {"cyan", "\033[36m"},   {"white", "\033[37m"}};

  auto it = colorCodes.find(color);
  std::cout << (it != colorCodes.end() ? it->second : "\033[0m") << text
            << "\033[0m" << std::endl;
}

int CheckFTarget(
    const std::vector<std::pair<std::string, std::string>> &FTargetsMap,
    const std::string &fnameStr) {
  for (size_t i = 0; i < FTargetsMap.size(); i++) {

    std::string firstStr = FTargetsMap[i].first;
    std::string secondStr = FTargetsMap[i].second;

    printColored(fnameStr, "green"); // Green
    printColored(firstStr, "red");   // Red
    printColored(secondStr, "blue"); // Blue

    bool equalsFirst = fnameStr == firstStr;
    bool equalsSecond = fnameStr.find(secondStr) != std::string::npos;

    std::cout << "Equals first: " << equalsFirst << std::endl;
    std::cout << "Contains second: " << equalsSecond << std::endl;

    if (equalsFirst || equalsSecond) {
      std::cout << "Match found at index: " << i << std::endl;
      return static_cast<int>(i);
    }
  }
  std::cout << "No match found" << std::endl;
  return -1;
}

bool VortexIntrinsicFuncLowering::runOnModule(Module &M) {
  Modified = false;
  llvm::errs() << "Printing LLVM Module:\n";
  M.print(llvm::errs(), nullptr); // Print the entire module to stderr
  std::cerr << "VORTEX Intrinsic Func pass " << std::endl;

  std::set<llvm::Function *> DeclToRemove;
  std::set<llvm::Instruction *> CallToRemove;
  std::set<llvm::Instruction *> vxBarCallToRemove;
  std::vector<StringRef> FTargets = {
      "vx_barrier",   "vx_num_threads", "vx_num_warps",
      "vx_num_cores", "vx_thread_id",   "vx_warp_id",
      "vx_core_id",   "vx_thread_mask", "vx_tmc",
      "vx_wmma", "vx_local_sw" // New WMMA intrinsic
  };
  std::vector<std::pair<std::string, std::string>> FTargetsMap = {
      {"vx_barrier", "llvm.riscv.vx.bar"},
      {"vx_num_threads", "llvm.riscv.vx.nt"},
      {"vx_num_warps", "llvm.riscv.vx.nw"},
      {"vx_num_cores", "llvm.riscv.vx.nc"},
      {"vx_thread_id", "llvm.riscv.vx.tid"},
      {"vx_warp_id", "llvm.riscv.vx.wid"},
      {"vx_core_id", "llvm.riscv.vx.cid"},
      {"vx_thread_mask", "llvm.riscv.vx.tmask"},
      {"vx_tmc", "llvm.riscv.vx.tmc"},
      {"vx_wmma", "llvm.riscv.vx_wmma"},
      {"local_sw", "llvm.riscv.vx_local_sw"},
      {"local_lw", "llvm.riscv.vx_local_lw"},
      {"vx_asyncbulk_ld_g2l_i32", "llvm.riscv.vx.asyncbulk.ld.g2l.i32"},
      {"vx_asyncbulk_ld_g2l_i64", "llvm.riscv.vx.asyncbulk.ld.g2l.i64"},
      {"vx_asyncbulk_st_l2g_i32", "llvm.riscv.vx.asyncbulk.st.l2g.i32"},
      {"vx_asyncbulk_st_l2g_i64", "llvm.riscv.vx.asyncbulk.st.l2g.i64"}

      };
  // Type* SizeTTy_;
  auto &Context = M.getContext();

  auto sizeTSize = M.getDataLayout().getPointerSizeInBits();
  /*switch (sizeTSize) {
    case 128: SizeTTy_ = llvm::Type::getInt128Ty(Context); break;
    case 64:  SizeTTy_ = llvm::Type::getInt64Ty(Context); break;
    case 32:  SizeTTy_ = llvm::Type::getInt32Ty(Context); break;
    case 16:  SizeTTy_ = llvm::Type::getInt16Ty(Context); break;
    case 8:   SizeTTy_ = llvm::Type::getInt8Ty(Context); break;
    default:
              SizeTTy_ = llvm::Type::getInt32Ty(Context); break;
  }*/

  Function *bar_func_;
  Function *tid_func_;
  Function *wid_func_;
  Function *cid_func_;
  Function *nt_func_;
  Function *nw_func_;
  Function *nc_func_;
  Function *tmask_func_;
  Function *tmc_func_;
  Function *wmma_func_; // New function pointer for WMMA intrinsic
  Function *local_sw_; // New function pointer for WMMA intrinsi
  Function *local_lw_; // New function pointer for WMMA intrinsi
  Function *asyncbulk_ld_g2l_i32_func_;
  Function *asyncbulk_ld_g2l_i64_func_;
  Function *asyncbulk_st_l2g_i32_func_;
  Function *asyncbulk_st_l2g_i64_func_;




  if (sizeTSize == 64) {
    bar_func_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_bar_i64);
    tid_func_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_tid_i64);
    wid_func_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_wid_i64);
    cid_func_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_cid_i64);
    nt_func_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_nt_i64);
    nw_func_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_nw_i64);
    nc_func_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_nc_i64);
    tmask_func_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_tmask_i64);
    tmc_func_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_tmc_i64);
    wmma_func_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_wmma_i64);
    local_sw_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_local_sw_i64);
    local_lw_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_local_lw_i64);
    asyncbulk_ld_g2l_i64_func_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_asyncbulk_ld_g2l_i64);
    asyncbulk_st_l2g_i64_func_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_asyncbulk_st_l2g_i64);

  } else {
    assert(sizeTSize == 32);
    bar_func_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_bar_i32);
    tid_func_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_tid_i32);
    wid_func_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_wid_i32);
    cid_func_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_cid_i32);
    nt_func_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_nt_i32);
    nw_func_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_nw_i32);
    nc_func_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_nc_i32);
    tmask_func_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_tmask_i32);
    tmc_func_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_tmc_i32);
    wmma_func_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_wmma_i32);
    local_sw_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_local_sw_i32);
    local_lw_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_local_lw_i32);
    asyncbulk_ld_g2l_i32_func_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_asyncbulk_ld_g2l_i32);
    asyncbulk_st_l2g_i32_func_ = Intrinsic::getDeclaration(&M, Intrinsic::riscv_vx_asyncbulk_st_l2g_i32);
  }

  // Find target vx intrinsic
  for (llvm::Module::iterator I = M.begin(), E = M.end(); I != E; ++I) {
    llvm::Function *F = &*I;
    if (F->isDeclaration()) {
      int check = CheckFTarget(FTargetsMap, F->getName().str());
      if (check != -1)
        DeclToRemove.insert(F);
      continue;
    }
    for (Function::iterator I = F->begin(), E = F->end(); I != E; ++I) {
      for (BasicBlock::iterator BI = I->begin(), BE = I->end(); BI != BE;
           ++BI) {
        Instruction *Instr = dyn_cast<Instruction>(BI);
        if (!llvm::isa<CallInst>(Instr))
          continue;
        CallInst *CallInstr = dyn_cast<CallInst>(Instr);
        Function *Callee = CallInstr->getCalledFunction();
        if (Callee == nullptr)
          continue;

        int check = CheckFTarget(FTargetsMap, Callee->getName().str());
        std::cout << "\033[34m" << "VORTEX_LOWERING" << "\033[0m" << std::endl;

        std::cout << "\033[34m" << check << "\033[0m" << std::endl;
        printColored("hiii", "magenta");

// In the main loop where instructions are processed, add these cases:
if (check == FTargetsMap.size() - 4) { // vx_asyncbulk_ld_g2l_i32
  CallInst *CallInstr = dyn_cast<CallInst>(Instr);
  Value *Arg0 = CallInstr->getArgOperand(0); // Base address register
  Value *Arg1 = CallInstr->getArgOperand(1); // Immediate offset
  Value *Arg2 = CallInstr->getArgOperand(2); // Number of addresses

  auto asyncbulk_ld_g2l_i32_inst = CallInst::Create(asyncbulk_ld_g2l_i32_func_, {Arg0, Arg1, Arg2}, "", Instr);
  Instr->replaceAllUsesWith(asyncbulk_ld_g2l_i32_inst);
  CallToRemove.insert(Instr);
}

if (check == FTargetsMap.size() - 3) { // vx_asyncbulk_ld_g2l_i64
  CallInst *CallInstr = dyn_cast<CallInst>(Instr);
  Value *Arg0 = CallInstr->getArgOperand(0); // Base address register
  Value *Arg1 = CallInstr->getArgOperand(1); // Immediate offset
  Value *Arg2 = CallInstr->getArgOperand(2); // Number of addresses

  auto asyncbulk_ld_g2l_i64_inst = CallInst::Create(asyncbulk_ld_g2l_i64_func_, {Arg0, Arg1, Arg2}, "", Instr);
  Instr->replaceAllUsesWith(asyncbulk_ld_g2l_i64_inst);
  CallToRemove.insert(Instr);
}

if (check == FTargetsMap.size() - 2) { // vx_asyncbulk_st_l2g_i32
  CallInst *CallInstr = dyn_cast<CallInst>(Instr);
  Value *Arg0 = CallInstr->getArgOperand(0); // Value to store
  Value *Arg1 = CallInstr->getArgOperand(1); // Base address register
  Value *Arg2 = CallInstr->getArgOperand(2); // Immediate offset
  Value *Arg3 = CallInstr->getArgOperand(3); // Number of addresses

  auto asyncbulk_st_l2g_i32_inst = CallInst::Create(asyncbulk_st_l2g_i32_func_, {Arg0, Arg1, Arg2, Arg3}, "", Instr);
  Instr->replaceAllUsesWith(asyncbulk_st_l2g_i32_inst);
  CallToRemove.insert(Instr);
}

if (check == FTargetsMap.size() - 1) { // vx_asyncbulk_st_l2g_i64
  CallInst *CallInstr = dyn_cast<CallInst>(Instr);
  Value *Arg0 = CallInstr->getArgOperand(0); // Value to store
  Value *Arg1 = CallInstr->getArgOperand(1); // Base address register
  Value *Arg2 = CallInstr->getArgOperand(2); // Immediate offset
  Value *Arg3 = CallInstr->getArgOperand(3); // Number of addresses

  auto asyncbulk_st_l2g_i64_inst = CallInst::Create(asyncbulk_st_l2g_i64_func_, {Arg0, Arg1, Arg2, Arg3}, "", Instr);
  Instr->replaceAllUsesWith(asyncbulk_st_l2g_i64_inst);
  CallToRemove.insert(Instr);
}

  if (check == 10) { // local_sw
  printColored("woahhhh","red");
  CallInst *CallInstr = dyn_cast<CallInst>(Instr);
  Value *Arg0 = CallInstr->getArgOperand(0); // Value to store
  Value *Arg1 = CallInstr->getArgOperand(1); // Base address register
  Value *Arg2 = CallInstr->getArgOperand(2); // Immediate offset

  auto local_sw_inst = CallInst::Create(local_sw_, {Arg0, Arg1, Arg2}, "", Instr);
  Instr->replaceAllUsesWith(local_sw_inst);
  CallToRemove.insert(Instr);
}

if (check == 11) { // local_lw
  CallInst *CallInstr = dyn_cast<CallInst>(Instr);
  Value *Arg0 = CallInstr->getArgOperand(0); // Base address register
  Value *Arg1 = CallInstr->getArgOperand(1); // Immediate offset

  auto local_lw_inst = CallInst::Create(local_lw_, {Arg0, Arg1}, "", Instr);
  Instr->replaceAllUsesWith(local_lw_inst);
  CallToRemove.insert(Instr);
}


        if (check == 9) { // WMMA case
          printColored("yooooooo", "magenta");
          CallInst *WMMACall = dyn_cast<CallInst>(Instr);

          // Collect all 12 arguments
          std::vector<Value *> Args;
          for (unsigned i = 0; i < 12; ++i) {
            Args.push_back(WMMACall->getArgOperand(i));
          }

          // Create a new WMMA instruction using wmma_func_
          CallInst *NewWMMACall = CallInst::Create(wmma_func_, Args, "", Instr);

          // If the original call had a name, give the new call the same name
          if (!Instr->getName().empty()) {
            NewWMMACall->setName(Instr->getName());
          }

          // Replace all uses of the old instruction with the new one
          Instr->replaceAllUsesWith(NewWMMACall);

          // Remove the original intrinsic call
          CallToRemove.insert(Instr);
        }
        if (check == 0) {
          vxBarCallToRemove.insert(Instr);

        } else if (check == 1) {
          auto ntinst = CallInst::Create(nt_func_, "nt", Instr);
          Instr->replaceAllUsesWith(ntinst);
          CallToRemove.insert(Instr);

        } else if (check == 2) {
          auto nwinst = CallInst::Create(nw_func_, "nw", Instr);
          Instr->replaceAllUsesWith(nwinst);
          CallToRemove.insert(Instr);

        } else if (check == 3) {
          auto ncinst = CallInst::Create(nc_func_, "nc", Instr);
          Instr->replaceAllUsesWith(ncinst);
          CallToRemove.insert(Instr);

        } else if (check == 4) {
          auto tidinst = CallInst::Create(tid_func_, "tid", Instr);
          Instr->replaceAllUsesWith(tidinst);
          CallToRemove.insert(Instr);

        } else if (check == 5) {
          auto widinst = CallInst::Create(wid_func_, "wid", Instr);
          Instr->replaceAllUsesWith(widinst);
          CallToRemove.insert(Instr);

        } 
        else if (check == 6) {
          auto cidinst = CallInst::Create(cid_func_, "cid", Instr);
          Instr->replaceAllUsesWith(cidinst);
          CallToRemove.insert(Instr);

        } else if (check == 7) {
          auto tmaskinst = CallInst::Create(tmask_func_, "tmask", Instr);
          Instr->replaceAllUsesWith(tmaskinst);
          CallToRemove.insert(Instr);

        } else if (check == 8) {
          CallInst *Callinst = dyn_cast<CallInst>(Instr);
          auto tmask = Callinst->getArgOperand(0);
          auto tmcinst = CallInst::Create(tmc_func_, {tmask}, "", Instr);
          Instr->replaceAllUsesWith(tmcinst);
          CallToRemove.insert(Instr);
        }

      } // end of BB loop
    } // end of F loop
  } // end of M loop
  printColored("END_OF_LOOP", "yellow");
  // Insert vx_barrier(barCnt, warp_size)
  if (!vxBarCallToRemove.empty()) {
    int barCnt = 1;
    for (auto B : vxBarCallToRemove) {

      CallInst *Callinst = dyn_cast<CallInst>(B);
      LLVMContext &context = M.getContext();
      auto barID =
          llvm::ConstantInt::get(context, llvm::APInt(32, (barCnt++), false));
      auto barCnt = Callinst->getArgOperand(1);
      // auto barCnt = llvm::ConstantInt::get(context, llvm::APInt(32, 4,
      // false));
      auto barinst = CallInst::Create(bar_func_, {barID, barCnt}, "", B);
      B->replaceAllUsesWith(barinst);
    }
    Modified = true;
  }

  for (auto B : vxBarCallToRemove) {
    B->eraseFromParent();
  }

  if (!CallToRemove.empty())
    Modified = true;

  for (auto B : CallToRemove) {
    B->eraseFromParent();
  }

  for (auto F : DeclToRemove) {
    if (F->use_empty()) {
      F->eraseFromParent();
    } else {
      errs() << "Warning: Cannot remove declaration of " << F->getName()
             << " because it still has uses.\n";
    }
  }
  printIR(&M);
  return Modified;
}
