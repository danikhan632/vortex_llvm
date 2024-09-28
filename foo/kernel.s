	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_a2p1_f2p2_zicsr2p0"
	.file	"kernel.cl"
	.option	push
	.option	arch, +c
	.globl	sgemm3                          # -- Begin function sgemm3
	.p2align	1
	.type	sgemm3,@function
sgemm3:                                 # @sgemm3
# %bb.0:
	addi	sp, sp, -160
	sw	ra, 156(sp)                     # 4-byte Folded Spill
	sw	s0, 152(sp)                     # 4-byte Folded Spill
	addi	s0, sp, 160
	sw	a5, -72(s0)                     # 4-byte Folded Spill
	sw	a4, -68(s0)                     # 4-byte Folded Spill
	sw	a3, -32(s0)                     # 4-byte Folded Spill
	sw	a2, -64(s0)                     # 4-byte Folded Spill
	sw	a1, -60(s0)                     # 4-byte Folded Spill
	sw	a0, -56(s0)                     # 4-byte Folded Spill
	li	a0, 1
	sw	a0, -48(s0)                     # 4-byte Folded Spill
	call	_Z13get_global_idj
	sw	a0, -52(s0)                     # 4-byte Folded Spill
	li	a0, 0
	sw	a0, -28(s0)                     # 4-byte Folded Spill
	call	_Z13get_global_idj
	mv	a1, a0
	lw	a0, -48(s0)                     # 4-byte Folded Reload
	sw	a1, -44(s0)                     # 4-byte Folded Spill
	call	_Z12get_local_idj
	mv	a1, a0
	lw	a0, -28(s0)                     # 4-byte Folded Reload
	sw	a1, -40(s0)                     # 4-byte Folded Spill
	call	_Z12get_local_idj
	mv	a1, a0
	lw	a0, -28(s0)                     # 4-byte Folded Reload
	sw	a1, -36(s0)                     # 4-byte Folded Spill
	call	_Z14get_local_sizej
	lw	a3, -32(s0)                     # 4-byte Folded Reload
	lw	a1, -28(s0)                     # 4-byte Folded Reload
	sw	a0, -24(s0)                     # 4-byte Folded Spill
	seqz	a0, a3
	vx_split	a2, a0
	sw	a2, -20(s0)                     # 4-byte Folded Spill
	fmv.w.x	fa5, zero
	fsw	fa5, -16(s0)                    # 4-byte Folded Spill
	sw	a1, -12(s0)                     # 4-byte Folded Spill
	bnez	a0, .LBB0_3
	j	.LBB0_1
.LBB0_1:
	lw	a1, -24(s0)                     # 4-byte Folded Reload
	lw	a0, -72(s0)                     # 4-byte Folded Reload
	lw	a3, -68(s0)                     # 4-byte Folded Reload
	lw	a4, -36(s0)                     # 4-byte Folded Reload
	lw	a2, -40(s0)                     # 4-byte Folded Reload
	lw	a5, -52(s0)                     # 4-byte Folded Reload
	lw	a6, -32(s0)                     # 4-byte Folded Reload
	mul	a5, a5, a6
	sw	a5, -108(s0)                    # 4-byte Folded Spill
	add	a5, a5, a4
	sw	a5, -104(s0)                    # 4-byte Folded Spill
	mul	a2, a1, a2
	sw	a2, -100(s0)                    # 4-byte Folded Spill
	add	a2, a2, a4
	slli	a2, a2, 2
	add	a3, a3, a2
	sw	a3, -96(s0)                     # 4-byte Folded Spill
	add	a0, a0, a2
	sw	a0, -92(s0)                     # 4-byte Folded Spill
	li	a0, 0
	slt	a1, a0, a1
	sw	a1, -88(s0)                     # 4-byte Folded Spill
	fmv.w.x	fa5, zero
	csrr	a1, tmask
	sw	a1, -84(s0)                     # 4-byte Folded Spill
	sw	a0, -80(s0)                     # 4-byte Folded Spill
	fsw	fa5, -76(s0)                    # 4-byte Folded Spill
	j	.LBB0_5
.LBB0_2:                                # %.loopexit1
	lw	a0, -108(s0)                    # 4-byte Folded Reload
	flw	fa5, -112(s0)                   # 4-byte Folded Reload
	fsw	fa5, -16(s0)                    # 4-byte Folded Spill
	sw	a0, -12(s0)                     # 4-byte Folded Spill
	j	.LBB0_3
.LBB0_3:                                # %join_stub3
	lw	a1, -20(s0)                     # 4-byte Folded Reload
	flw	fa5, -16(s0)                    # 4-byte Folded Reload
	lw	a0, -12(s0)                     # 4-byte Folded Reload
	vx_join	a1
	sw	a0, -120(s0)                    # 4-byte Folded Spill
	fsw	fa5, -116(s0)                   # 4-byte Folded Spill
	j	.LBB0_4
.LBB0_4:
	lw	a0, -64(s0)                     # 4-byte Folded Reload
	lw	a2, -44(s0)                     # 4-byte Folded Reload
	lw	a1, -120(s0)                    # 4-byte Folded Reload
	flw	fa5, -116(s0)                   # 4-byte Folded Reload
	add	a1, a1, a2
	slli	a1, a1, 2
	add	a0, a0, a1
	fsw	fa5, 0(a0)
	lw	ra, 156(sp)                     # 4-byte Folded Reload
	lw	s0, 152(sp)                     # 4-byte Folded Reload
	addi	sp, sp, 160
	ret
.LBB0_5:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_10 Depth 2
	lw	a0, -88(s0)                     # 4-byte Folded Reload
	lw	a2, -44(s0)                     # 4-byte Folded Reload
	lw	a1, -92(s0)                     # 4-byte Folded Reload
	lw	a3, -60(s0)                     # 4-byte Folded Reload
	lw	a5, -32(s0)                     # 4-byte Folded Reload
	lw	a6, -40(s0)                     # 4-byte Folded Reload
	lw	a7, -96(s0)                     # 4-byte Folded Reload
	lw	t0, -56(s0)                     # 4-byte Folded Reload
	lw	t1, -104(s0)                    # 4-byte Folded Reload
	lw	a4, -80(s0)                     # 4-byte Folded Reload
	flw	fa5, -76(s0)                    # 4-byte Folded Reload
	fsw	fa5, -136(s0)                   # 4-byte Folded Spill
	sw	a4, -132(s0)                    # 4-byte Folded Spill
	add	t1, t1, a4
	slli	t1, t1, 2
	add	t0, t0, t1
	flw	fa4, 0(t0)
	fsw	fa4, 0(a7)
	add	a4, a4, a6
	mul	a4, a4, a5
	add	a4, a4, a2
	slli	a4, a4, 2
	add	a3, a3, a4
	flw	fa4, 0(a3)
	fsw	fa4, 0(a1)
	li	a1, 1
	vx_bar	a1, a2
	andi	a0, a0, 1
	vx_split_n	a1, a0
	sw	a1, -128(s0)                    # 4-byte Folded Spill
	fsw	fa5, -124(s0)                   # 4-byte Folded Spill
	beqz	a0, .LBB0_8
	j	.LBB0_6
.LBB0_6:                                # %.preheader
                                        #   in Loop: Header=BB0_5 Depth=1
	flw	fa5, -136(s0)                   # 4-byte Folded Reload
	li	a0, 0
	csrr	a1, tmask
	sw	a1, -148(s0)                    # 4-byte Folded Spill
	sw	a0, -144(s0)                    # 4-byte Folded Spill
	fsw	fa5, -140(s0)                   # 4-byte Folded Spill
	j	.LBB0_10
.LBB0_7:                                # %.loopexit
                                        #   in Loop: Header=BB0_5 Depth=1
	flw	fa5, -152(s0)                   # 4-byte Folded Reload
	fsw	fa5, -124(s0)                   # 4-byte Folded Spill
	j	.LBB0_8
.LBB0_8:                                # %join_stub
                                        #   in Loop: Header=BB0_5 Depth=1
	lw	a0, -128(s0)                    # 4-byte Folded Reload
	flw	fa5, -124(s0)                   # 4-byte Folded Reload
	vx_join	a0
	fsw	fa5, -156(s0)                   # 4-byte Folded Spill
	j	.LBB0_9
.LBB0_9:                                #   in Loop: Header=BB0_5 Depth=1
	lw	a2, -84(s0)                     # 4-byte Folded Reload
	lw	a0, -32(s0)                     # 4-byte Folded Reload
	lw	a1, -132(s0)                    # 4-byte Folded Reload
	lw	a3, -24(s0)                     # 4-byte Folded Reload
	lw	a5, -44(s0)                     # 4-byte Folded Reload
	flw	fa5, -156(s0)                   # 4-byte Folded Reload
	fsw	fa5, -112(s0)                   # 4-byte Folded Spill
	li	a4, 2
	vx_bar	a4, a5
	add	a1, a1, a3
	sltu	a0, a1, a0
	xori	a0, a0, 1
	vx_pred_n	a0, a2
	sw	a1, -80(s0)                     # 4-byte Folded Spill
	fsw	fa5, -76(s0)                    # 4-byte Folded Spill
	bnez	a0, .LBB0_2
	j	.LBB0_5
.LBB0_10:                               #   Parent Loop BB0_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	flw	fa3, -140(s0)                   # 4-byte Folded Reload
	lw	a1, -144(s0)                    # 4-byte Folded Reload
	lw	a2, -148(s0)                    # 4-byte Folded Reload
	lw	a0, -24(s0)                     # 4-byte Folded Reload
	lw	a3, -72(s0)                     # 4-byte Folded Reload
	lw	a5, -36(s0)                     # 4-byte Folded Reload
	lw	a4, -68(s0)                     # 4-byte Folded Reload
	lw	a6, -100(s0)                    # 4-byte Folded Reload
	add	a6, a6, a1
	slli	a6, a6, 2
	add	a4, a4, a6
	flw	fa5, 0(a4)
	mul	a4, a1, a0
	add	a4, a4, a5
	slli	a4, a4, 2
	add	a3, a3, a4
	flw	fa4, 0(a3)
	fmadd.s	fa5, fa5, fa4, fa3
	fsw	fa5, -152(s0)                   # 4-byte Folded Spill
	addi	a1, a1, 1
	xor	a0, a0, a1
	seqz	a0, a0
	vx_pred_n	a0, a2
	sw	a1, -144(s0)                    # 4-byte Folded Spill
	fsw	fa5, -140(s0)                   # 4-byte Folded Spill
	bnez	a0, .LBB0_7
	j	.LBB0_10
.Lfunc_end0:
	.size	sgemm3, .Lfunc_end0-sgemm3
                                        # -- End function
	.option	pop
	.ident	"Ubuntu clang version 16.0.6 (15)"
	.section	".note.GNU-stack","",@progbits
