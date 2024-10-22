	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_a2p1_f2p2_zicond1p0_zicsr2p0"
	.file	"kernel.cl"
	.option	push
	.option	arch, +c
	.globl	sgemm3                          # -- Begin function sgemm3
	.p2align	1
	.type	sgemm3,@function
sgemm3:                                 # @sgemm3
# %bb.0:
	addi	sp, sp, -64
	sw	ra, 60(sp)                      # 4-byte Folded Spill
	sw	s0, 56(sp)                      # 4-byte Folded Spill
	sw	s1, 52(sp)                      # 4-byte Folded Spill
	sw	s2, 48(sp)                      # 4-byte Folded Spill
	sw	s3, 44(sp)                      # 4-byte Folded Spill
	sw	s4, 40(sp)                      # 4-byte Folded Spill
	sw	s5, 36(sp)                      # 4-byte Folded Spill
	sw	s6, 32(sp)                      # 4-byte Folded Spill
	sw	s7, 28(sp)                      # 4-byte Folded Spill
	sw	s8, 24(sp)                      # 4-byte Folded Spill
	sw	s9, 20(sp)                      # 4-byte Folded Spill
	sw	s10, 16(sp)                     # 4-byte Folded Spill
	sw	s11, 12(sp)                     # 4-byte Folded Spill
	addi	s0, sp, 64
	mv	s8, a5
	mv	s7, a4
	mv	s5, a3
	mv	s1, a2
	mv	s3, a1
	mv	s4, a0
	li	a0, 1
	li	s11, 1
	call	_Z13get_global_idj
	mv	s9, a0
	li	a0, 0
	call	_Z13get_global_idj
	mv	s2, a0
	li	a0, 1
	call	_Z12get_local_idj
	mv	s6, a0
	li	a0, 0
	call	_Z12get_local_idj
	mv	s10, a0
	li	a0, 0
	call	_Z14get_local_sizej
	li	a7, 0
	seqz	a1, s5
	vx_split	a6, a1
	fmv.w.x	fa5, zero
	bnez	a1, .LBB0_7
# %bb.1:
	mv	ra, s1
	li	t6, 0
	mul	a7, s9, s5
	add	t0, s10, a7
	mul	a1, a0, s6
	add	a2, a1, s10
	slli	a2, a2, 2
	add	t2, s7, a2
	add	t3, s8, a2
	slli	s10, s10, 2
	add	s8, s8, s10
	slli	s1, a0, 2
	slli	a1, a1, 2
	add	s7, s7, a1
	fmv.w.x	fa5, zero
	csrr	t4, tmask
	li	t1, 2
	j	.LBB0_3
.LBB0_2:                                # %join_stub
                                        #   in Loop: Header=BB0_3 Depth=1
	vx_join	t5
	vx_bar	t1, s2
	add	t6, t6, a0
	sltu	a1, t6, s5
	xori	a1, a1, 1
	vx_pred_n	a1, t4
	bnez	a1, .LBB0_6
.LBB0_3:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_5 Depth 2
	add	a1, t0, t6
	slli	a1, a1, 2
	add	a1, a1, s4
	flw	fa4, 0(a1)
	fsw	fa4, 0(t2)
	add	a1, t6, s6
	mul	a1, a1, s5
	add	a1, a1, s2
	slli	a1, a1, 2
	add	a1, a1, s3
	lw	a1, 0(a1)
	sgtz	a2, a0
	#APP
	vx_local_sw	a1, 0(t3)

	vx_bar	s11, s2
	vx_split_n	t5, a2
	beqz	a2, .LBB0_2
# %bb.4:                                # %.preheader.preheader
                                        #   in Loop: Header=BB0_3 Depth=1
	csrr	a1, tmask
	mv	a4, s7
	mv	a2, s8
	mv	a5, a0
.LBB0_5:                                # %.preheader
                                        #   Parent Loop BB0_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	flw	fa4, 0(a4)
	flw	fa3, 0(a2)
	fmadd.s	fa5, fa4, fa3, fa5
	addi	a5, a5, -1
	add	a2, a2, s1
	addi	a4, a4, 4
	seqz	a3, a5
	vx_pred_n	a3, a1
	beqz	a3, .LBB0_5
	j	.LBB0_2
.LBB0_6:                                # %.loopexit7
	mv	s1, ra
.LBB0_7:                                # %join_stub9
	vx_join	a6
	add	a7, a7, s2
	slli	a7, a7, 2
	add	a7, a7, s1
	fsw	fa5, 0(a7)
	lw	ra, 60(sp)                      # 4-byte Folded Reload
	lw	s0, 56(sp)                      # 4-byte Folded Reload
	lw	s1, 52(sp)                      # 4-byte Folded Reload
	lw	s2, 48(sp)                      # 4-byte Folded Reload
	lw	s3, 44(sp)                      # 4-byte Folded Reload
	lw	s4, 40(sp)                      # 4-byte Folded Reload
	lw	s5, 36(sp)                      # 4-byte Folded Reload
	lw	s6, 32(sp)                      # 4-byte Folded Reload
	lw	s7, 28(sp)                      # 4-byte Folded Reload
	lw	s8, 24(sp)                      # 4-byte Folded Reload
	lw	s9, 20(sp)                      # 4-byte Folded Reload
	lw	s10, 16(sp)                     # 4-byte Folded Reload
	lw	s11, 12(sp)                     # 4-byte Folded Reload
	addi	sp, sp, 64
	ret
.Lfunc_end0:
	.size	sgemm3, .Lfunc_end0-sgemm3
                                        # -- End function
	.option	pop
	.ident	"Ubuntu clang version 16.0.6 (15)"
	.section	".note.GNU-stack","",@progbits
