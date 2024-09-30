
kernel.o:	file format elf32-littleriscv

Disassembly of section .text:

00000000 <sgemm3>:
       0: 39 71        	<unknown>
       2: 06 de        	<unknown>
       4: 22 dc        	<unknown>
       6: 26 da        	<unknown>
       8: 4a d8        	<unknown>
       a: 4e d6        	<unknown>
       c: 52 d4        	<unknown>
       e: 56 d2        	<unknown>
      10: 5a d0        	<unknown>
      12: 5e ce        	<unknown>
      14: 62 cc        	<unknown>
      16: 66 ca        	<unknown>
      18: 6a c8        	<unknown>
      1a: 6e c6        	<unknown>
      1c: 80 00        	<unknown>
      1e: 3e 8c        	<unknown>
      20: ba 8b        	<unknown>
      22: b6 8a        	<unknown>
      24: 23 24 c4 fc  	sw	a2, -0x38(s0)
      28: ae 89        	<unknown>
      2a: 2a 8a        	<unknown>
      2c: 05 45        	<unknown>
      2e: 85 4d        	<unknown>
      30: 97 00 00 00  	auipc	ra, 0x0
      34: e7 80 00 00  	jalr	ra, 0x0(ra) <sgemm3+0x30>
      38: aa 8c        	<unknown>
      3a: 01 45        	<unknown>
      3c: 97 00 00 00  	auipc	ra, 0x0
      40: e7 80 00 00  	jalr	ra, 0x0(ra) <sgemm3+0x3c>
      44: 2a 89        	<unknown>
      46: 05 45        	<unknown>
      48: 97 00 00 00  	auipc	ra, 0x0
      4c: e7 80 00 00  	jalr	ra, 0x0(ra) <sgemm3+0x48>
      50: 2a 8b        	<unknown>
      52: 01 45        	<unknown>
      54: 97 00 00 00  	auipc	ra, 0x0
      58: e7 80 00 00  	jalr	ra, 0x0(ra) <sgemm3+0x54>
      5c: 2a 8d        	<unknown>
      5e: 01 45        	<unknown>
      60: 97 00 00 00  	auipc	ra, 0x0
      64: e7 80 00 00  	jalr	ra, 0x0(ra) <sgemm3+0x60>
      68: 81 48        	<unknown>
      6a: 93 b5 1a 00  	sltiu	a1, s5, 0x1
      6e: 0b a8 15 00  	vx_split_n	a6, a1
      72: d3 07 00 f0  	fmv.w.x	fa5, zero
      76: 9d c9        	<unknown>
      78: 0b 30 08 00  	vx_join	a6
      7c: ca 98        	<unknown>
      7e: 8a 08        	<unknown>
      80: 03 25 84 fc  	lw	a0, -0x38(s0)
      84: aa 98        	<unknown>
      86: 27 a0 f8 00  	fsw	fa5, 0x0(a7)
      8a: 13 01 04 fc  	addi	sp, s0, -0x40
      8e: f2 50        	<unknown>
      90: 62 54        	<unknown>
      92: d2 54        	<unknown>
      94: 42 59        	<unknown>
      96: b2 59        	<unknown>
      98: 22 5a        	<unknown>
      9a: 92 5a        	<unknown>
      9c: 02 5b        	<unknown>
      9e: f2 4b        	<unknown>
      a0: 62 4c        	<unknown>
      a2: d2 4c        	<unknown>
      a4: 42 4d        	<unknown>
      a6: b2 4d        	<unknown>
      a8: 21 61        	<unknown>
      aa: 82 80        	<unknown>
      ac: 81 4f        	<unknown>
      ae: b3 88 5c 03  	mul	a7, s9, s5
      b2: b3 02 1d 01  	add	t0, s10, a7
      b6: b3 05 65 03  	mul	a1, a0, s6
      ba: 33 86 a5 01  	add	a2, a1, s10
      be: 0a 06        	<unknown>
      c0: b3 83 cb 00  	add	t2, s7, a2
      c4: 33 0e cc 00  	add	t3, s8, a2
      c8: 0a 0d        	<unknown>
      ca: 6a 9c        	<unknown>
      cc: 93 1c 25 00  	slli	s9, a0, 0x2
      d0: 8a 05        	<unknown>
      d2: ae 9b        	<unknown>
      d4: d3 07 00 f0  	fmv.w.x	fa5, zero
      d8: f3 2e 40 cc  	csrrs	t4, tmask, zero
      dc: 09 43        	<unknown>
      de: 29 a8        	<unknown>
      e0: 0b 30 0f 00  	vx_join	t5
      e4: 0b 40 23 01  	vx_bar	t1, s2
      e8: aa 9f        	<unknown>
      ea: b3 b5 5f 01  	sltu	a1, t6, s5
      ee: 93 c5 15 00  	xori	a1, a1, 0x1
      f2: 8b d0 d5 01  	vx_pred_n	a1, t4
      f6: c9 f1        	<unknown>
      f8: b3 25 a0 00  	slt	a1, zero, a0
      fc: 33 86 f2 01  	add	a2, t0, t6
     100: 0a 06        	<unknown>
     102: 52 96        	<unknown>
     104: 0a 87        	<unknown>
     106: 93 07 07 ff  	addi	a5, a4, -0x10
     10a: 3e 81        	<unknown>
     10c: eb 07 06 00  	vx_local_lw	a5, 0x0(a2)
     110: 03 26 07 ff  	lw	a2, -0x10(a4)
     114: 6b 90 c3 00  	vx_local_sw	a2, 0x0(t2)
     118: 33 86 6f 01  	add	a2, t6, s6
     11c: 33 06 56 03  	mul	a2, a2, s5
     120: 4a 96        	<unknown>
     122: 0a 06        	<unknown>
     124: 4e 96        	<unknown>
     126: 0a 87        	<unknown>
     128: 93 07 07 ff  	addi	a5, a4, -0x10
     12c: 3e 81        	<unknown>
     12e: eb 07 06 00  	vx_local_lw	a5, 0x0(a2)
     132: 03 26 07 ff  	lw	a2, -0x10(a4)
     136: 6b 10 ce 00  	vx_local_sw	a2, 0x0(t3)
     13a: 0b c0 2d 01  	vx_bar	s11, s2
     13e: 0b af 15 00  	vx_split_n	t5, a1
     142: d9 dd        	<unknown>
     144: f3 25 40 cc  	csrrs	a1, tmask, zero
     148: 5e 87        	<unknown>
     14a: 62 86        	<unknown>
     14c: aa 87        	<unknown>
     14e: 8a 84        	<unknown>
     150: 93 86 04 ff  	addi	a3, s1, -0x10
     154: 36 81        	<unknown>
     156: eb 06 07 00  	vx_local_lw	a3, 0x0(a4)
     15a: 07 a7 04 ff  	flw	fa4, -0x10(s1)
     15e: 8a 86        	<unknown>
     160: 93 84 06 ff  	addi	s1, a3, -0x10
     164: 26 81        	<unknown>
     166: eb 04 06 00  	vx_local_lw	s1, 0x0(a2)
     16a: 87 a6 06 ff  	flw	fa3, -0x10(a3)
     16e: c3 77 d7 78  	fmadd.s	fa5, fa4, fa3, fa5, dyn
     172: fd 17        	<unknown>
     174: 66 96        	<unknown>
     176: 11 07        	<unknown>
     178: 93 b6 17 00  	sltiu	a3, a5, 0x1
     17c: 8b d0 b6 00  	vx_pred_n	a3, a1
     180: f9 d6        	<unknown>
     182: b9 bf        	<unknown>
