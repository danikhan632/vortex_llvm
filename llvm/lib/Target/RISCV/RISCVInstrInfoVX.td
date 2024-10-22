// Vortex instructions definitions

// Custom opcode definitions
def RISCV_CUSTOM0 : RISCVOpcode<"CUSTOM0", 0b0001011>;   // 0x0B
def RISCV_CUSTOM1 : RISCVOpcode<"CUSTOM1", 0b0101011>;   // 0x2B
def RISCV_CUSTOM2 : RISCVOpcode<"CUSTOM2", 0b1011011>;   // 0x5B
def RISCV_CUSTOM3 : RISCVOpcode<"CUSTOM3", 0b1111011>;   // 0x7B
def RISCV_CUSTOM4 : RISCVOpcode<"CUSTOM4", 0b1101011>;

// Vortex memory access instructions
// Define a 7-bit signed immediate for the offset



// Local Load Instruction
let hasSideEffects = 1, mayLoad = 1, mayStore = 0 in {
  def VX_LOCAL_LW : RVInstI<0b110, RISCV_CUSTOM4, 
                            (outs GPR:$rd), 
                            (ins GPR:$rs1, simm12:$imm12),
                            "vx_local_lw", 
                            "$rd, ${imm12}(${rs1})"> {
    let Inst{31-25} = 0b0000000;
  }
}

// Local Store Instruction
let hasSideEffects = 1, mayLoad = 0, mayStore = 1 in {
  def VX_LOCAL_SW : RVInstS<0b100, RISCV_CUSTOM4, 
                            (outs), 
                            (ins GPR:$rs2, GPR:$rs1, simm12:$imm12),
                            "vx_local_sw", 
                            "$rs2, ${imm12}(${rs1})"> {
    let Inst{31-25} = 0b0000000;
  }
}
//-----------------------------------------------------------------------------------------------
// Asyncbulk Load Instructions (Global to Local)
let hasSideEffects = 1, mayLoad = 1, mayStore = 0 in {
  def VX_ASYNCBULK_LD_G2L_I32 : RVInstI<0b101, RISCV_CUSTOM2, 
                                      (outs GPR:$rd), 
                                      (ins GPR:$rs1, simm12:$imm12, uimm5:$num_addresses),
                                      "vx.asyncbulk.ld.g2l.i32", 
                                      "$rd, ${imm12}(${rs1}), $num_addresses"> {
    let Inst{31-25} = 0b0000001; // Unique funct7 for LD_I32
  }

  def VX_ASYNCBULK_LD_G2L_I64 : RVInstI<0b001, RISCV_CUSTOM2, 
                                      (outs GPR:$rd), 
                                      (ins GPR:$rs1, simm12:$imm12, uimm5:$num_addresses),
                                      "vx.asyncbulk.ld.g2l.i64", 
                                      "$rd, ${imm12}(${rs1}), $num_addresses"> {
    let Inst{31-25} = 0b0000010; // Unique funct7 for LD_I64
  }
}

// Asyncbulk Store Instructions (Local to Global)
let hasSideEffects = 1, mayLoad = 0, mayStore = 1 in {
  def VX_ASYNCBULK_ST_L2G_I32 : RVInstS<0b100, RISCV_CUSTOM2, 
                                      (outs), 
                                      (ins GPR:$rs2, GPR:$rs1, simm12:$imm12, uimm5:$num_addresses),
                                      "vx.asyncbulk.st.l2g.i32", 
                                      "$rs2, ${imm12}(${rs1}), $num_addresses"> {
    let Inst{31-25} = 0b0000001; // Unique funct7 for ST_I32
  }

  def VX_ASYNCBULK_ST_L2G_I64 : RVInstS<0b101, RISCV_CUSTOM2, 
                                      (outs), 
                                      (ins GPR:$rs2, GPR:$rs1, simm12:$imm12, uimm5:$num_addresses),
                                      "vx.asyncbulk.st.l2g.i64", 
                                      "$rs2, ${imm12}(${rs1}), $num_addresses"> {
    let Inst{31-25} = 0b0000010; // Unique funct7 for ST_I64
  }
}

// Pattern definitions
def : Pat<(int_riscv_vx_asyncbulk_ld_g2l_i32 GPR:$rs1, simm12:$imm12, uimm5:$num_addresses),
          (VX_ASYNCBULK_LD_G2L_I32 GPR:$rs1, simm12:$imm12, uimm5:$num_addresses)>;

def : Pat<(int_riscv_vx_asyncbulk_ld_g2l_i64 GPR:$rs1, simm12:$imm12, uimm5:$num_addresses),
          (VX_ASYNCBULK_LD_G2L_I64 GPR:$rs1, simm12:$imm12, uimm5:$num_addresses)>;

def : Pat<(int_riscv_vx_asyncbulk_st_l2g_i32 GPR:$rs2, GPR:$rs1, simm12:$imm12, uimm5:$num_addresses),
          (VX_ASYNCBULK_ST_L2G_I32 GPR:$rs2, GPR:$rs1, simm12:$imm12, uimm5:$num_addresses)>;

def : Pat<(int_riscv_vx_asyncbulk_st_l2g_i64 GPR:$rs2, GPR:$rs1, simm12:$imm12, uimm5:$num_addresses),
          (VX_ASYNCBULK_ST_L2G_I64 GPR:$rs2, GPR:$rs1, simm12:$imm12, uimm5:$num_addresses)>;





//-----------------------------------------------------------------------------------------------



// Existing Local Load/Store Intrinsics
def : Pat<(int_riscv_vx_local_lw_i32 GPR:$rs1, simm12:$imm12),
          (VX_LOCAL_LW GPR:$rs1, simm12:$imm12)>;

def : Pat<(int_riscv_vx_local_sw_i32 GPR:$rs1, GPR:$rs2, simm12:$imm12),
          (VX_LOCAL_SW GPR:$rs2, GPR:$rs1, simm12:$imm12)>;

def : Pat<(int_riscv_vx_local_lw_i64 GPR:$rs1, simm12:$imm12),
          (VX_LOCAL_LW GPR:$rs1, simm12:$imm12)>;

def : Pat<(int_riscv_vx_local_sw_i64 GPR:$rs1, GPR:$rs2, simm12:$imm12),
          (VX_LOCAL_SW GPR:$rs2, GPR:$rs1, simm12:$imm12)>;

// Vortex control flow instructions

let hasSideEffects = 1, mayStore = 0, mayLoad = 0 in {
  def VX_TMC : RVInstR<0, 0, RISCV_CUSTOM0, (outs), (ins GPR:$rs1),
                       "vx_tmc", "$rs1">, Sched<[]> {
    let rd  = 0;
    let rs2 = 0;
  }

  def VX_WSPAWN : RVInstR<0, 1, RISCV_CUSTOM0, (outs), (ins GPR:$rs1, GPR:$rs2),
                          "vx_wspawn", "$rs1, $rs2">, Sched<[]> {
    let rd = 0;
  }

  def VX_SPLIT : RVInstR<0, 2, RISCV_CUSTOM0, (outs GPR:$rd), (ins GPR:$rs1),
                         "vx_split", "$rd, $rs1">, Sched<[]> {
    let rs2 = 0;
  }

  def VX_SPLIT_N : RVInstR<0, 2, RISCV_CUSTOM0, (outs GPR:$rd), (ins GPR:$rs1),
                           "vx_split_n", "$rd, $rs1">, Sched<[]> {
    let rs2 = 1;
  }

  def VX_JOIN : RVInstR<0, 3, RISCV_CUSTOM0, (outs), (ins GPR:$rs1),
                        "vx_join", "$rs1">, Sched<[]> {
    let rd  = 0;
    let rs2 = 0;
  }

  def VX_BAR : RVInstR<0, 4, RISCV_CUSTOM0, (outs), (ins GPR:$rs1, GPR:$rs2),
                       "vx_bar", "$rs1, $rs2">, Sched<[]> {
    let rd = 0;
    let isBarrier = 1;
  }

  def VX_PRED : RVInstR<0, 5, RISCV_CUSTOM0, (outs), (ins GPR:$rs1, GPR:$rs2),
                        "vx_pred", "$rs1, $rs2">, Sched<[]> {
    let rd = 0;
  }

  def VX_PRED_N : RVInstR<0, 5, RISCV_CUSTOM0, (outs), (ins GPR:$rs1, GPR:$rs2),
                          "vx_pred_n", "$rs1, $rs2">, Sched<[]> {
    let rd = 1;
  }

  def VX_RAST : RVInstR<1, 0, RISCV_CUSTOM0, (outs GPR:$rd), (ins),
                        "vx_rast", "">, Sched<[]> {
    let rs1 = 0;
    let rs2 = 0;
  }

  def VX_TEX : RVInstR4<0, 0, RISCV_CUSTOM1, (outs GPR:$rd), (ins GPR:$rs1, GPR:$rs2, GPR:$rs3),
                        "vx_tex", "$rd, $rs1, $rs2, $rs3">, Sched<[]> {}

  def VX_ROP : RVInstR4<0, 1, RISCV_CUSTOM1, (outs), (ins GPR:$rs1, GPR:$rs2, GPR:$rs3),
                        "vx_rop", "$rs1, $rs2, $rs3">, Sched<[]> {
    let rd = 0;
  }
}



// Pseudo Instructions
def VX_MOV : Pseudo<(outs GPR:$dst), (ins GPR:$src), [], "vx_mov", "$dst, $src"> {}

// CSR definitions
def CSR_NT    : SysReg<"nt",    0xFC0>;
def CSR_NW    : SysReg<"nw",    0xFC1>;
def CSR_NC    : SysReg<"nc",    0xFC2>;
def CSR_NG    : SysReg<"ng",    0xFC3>;
def CSR_TID   : SysReg<"tid",   0xCC0>;
def CSR_WID   : SysReg<"wid",   0xCC1>;
def CSR_CID   : SysReg<"cid",   0xCC2>;
def CSR_GID   : SysReg<"gid",   0xCC3>;
def CSR_TMASK : SysReg<"tmask", 0xCC4>;

// Patterns for CSR Intrinsics

def : Pat<(int_riscv_vx_tid_i32),   (CSRRS CSR_TID.Encoding,   (XLenVT X0))>;
def : Pat<(int_riscv_vx_tid_i64),   (CSRRS CSR_TID.Encoding,   (XLenVT X0))>;
def : Pat<(int_riscv_vx_wid_i32),   (CSRRS CSR_WID.Encoding,   (XLenVT X0))>;
def : Pat<(int_riscv_vx_wid_i64),   (CSRRS CSR_WID.Encoding,   (XLenVT X0))>;
def : Pat<(int_riscv_vx_cid_i32),   (CSRRS CSR_CID.Encoding,   (XLenVT X0))>;
def : Pat<(int_riscv_vx_cid_i64),   (CSRRS CSR_CID.Encoding,   (XLenVT X0))>;
def : Pat<(int_riscv_vx_nt_i32),    (CSRRS CSR_NT.Encoding,    (XLenVT X0))>;
def : Pat<(int_riscv_vx_nt_i64),    (CSRRS CSR_NT.Encoding,    (XLenVT X0))>;
def : Pat<(int_riscv_vx_nw_i32),    (CSRRS CSR_NW.Encoding,    (XLenVT X0))>;
def : Pat<(int_riscv_vx_nw_i64),    (CSRRS CSR_NW.Encoding,    (XLenVT X0))>;
def : Pat<(int_riscv_vx_nc_i32),    (CSRRS CSR_NC.Encoding,    (XLenVT X0))>;
def : Pat<(int_riscv_vx_nc_i64),    (CSRRS CSR_NC.Encoding,    (XLenVT X0))>;
def : Pat<(int_riscv_vx_tmask_i32), (CSRRS CSR_TMASK.Encoding, (XLenVT X0))>;
def : Pat<(int_riscv_vx_tmask_i64), (CSRRS CSR_TMASK.Encoding, (XLenVT X0))>;

// Patterns for Control Flow Intrinsics

def : Pat<(int_riscv_vx_tmc_i32 GPR:$rs1),     (VX_TMC GPR:$rs1)>;
def : Pat<(int_riscv_vx_tmc_i64 GPR:$rs1),     (VX_TMC GPR:$rs1)>;

def : Pat<(int_riscv_vx_pred_i32 GPR:$rs1, GPR:$rs2),   (VX_PRED GPR:$rs1, GPR:$rs2)>;
def : Pat<(int_riscv_vx_pred_i64 GPR:$rs1, GPR:$rs2),   (VX_PRED GPR:$rs1, GPR:$rs2)>;

def : Pat<(int_riscv_vx_pred_n_i32 GPR:$rs1, GPR:$rs2), (VX_PRED_N GPR:$rs1, GPR:$rs2)>;
def : Pat<(int_riscv_vx_pred_n_i64 GPR:$rs1, GPR:$rs2), (VX_PRED_N GPR:$rs1, GPR:$rs2)>;

def : Pat<(int_riscv_vx_split_i32 GPR:$rs1),   (VX_SPLIT GPR:$rs1)>;
def : Pat<(int_riscv_vx_split_i64 GPR:$rs1),   (VX_SPLIT GPR:$rs1)>;

def : Pat<(int_riscv_vx_split_n_i32 GPR:$rs1), (VX_SPLIT_N GPR:$rs1)>;
def : Pat<(int_riscv_vx_split_n_i64 GPR:$rs1), (VX_SPLIT_N GPR:$rs1)>;

def : Pat<(int_riscv_vx_join_i32 GPR:$rs1),    (VX_JOIN GPR:$rs1)>;
def : Pat<(int_riscv_vx_join_i64 GPR:$rs1),    (VX_JOIN GPR:$rs1)>;

def : Pat<(int_riscv_vx_mov_i32 GPR:$src),     (VX_MOV GPR:$src)>;
def : Pat<(int_riscv_vx_mov_i64 GPR:$src),     (VX_MOV GPR:$src)>;

def : Pat<(int_riscv_vx_bar_i32 GPR:$rs1, GPR:$rs2),    (VX_BAR GPR:$rs1, GPR:$rs2)>;
def : Pat<(int_riscv_vx_bar_i64 GPR:$rs1, GPR:$rs2),    (VX_BAR GPR:$rs1, GPR:$rs2)>;




// WMMA instruction with adjusted format
let hasSideEffects = 0, mayStore = 0, mayLoad = 0 in {
  def VX_WMMA : RVInstR<0, 2, RISCV_CUSTOM1, (outs),
                       (ins GPR:$rd, GPR:$rs1, GPR:$rs2),
                       "vx_wmma", "$rd, $rs2">, Sched<[]> {
  
  }
}
// WMMA intrinsic patterns for simplified instruction

