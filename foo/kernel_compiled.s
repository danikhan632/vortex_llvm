
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
      24: b2 84        	<unknown>
      26: ae 89        	<unknown>
      28: 2a 8a        	<unknown>
      2a: 05 45        	<unknown>
      2c: 85 4d        	<unknown>
      2e: 97 00 00 00  	auipc	ra, 0x0
      32: e7 80 00 00  	jalr	ra, 0x0(ra) <sgemm3+0x2e>
      36: aa 8c        	<unknown>
      38: 01 45        	<unknown>
      3a: 97 00 00 00  	auipc	ra, 0x0
      3e: e7 80 00 00  	jalr	ra, 0x0(ra) <sgemm3+0x3a>
      42: 2a 89        	<unknown>
      44: 05 45        	<unknown>
      46: 97 00 00 00  	auipc	ra, 0x0
      4a: e7 80 00 00  	jalr	ra, 0x0(ra) <sgemm3+0x46>
      4e: 2a 8b        	<unknown>
      50: 01 45        	<unknown>
      52: 97 00 00 00  	auipc	ra, 0x0
      56: e7 80 00 00  	jalr	ra, 0x0(ra) <sgemm3+0x52>
      5a: 2a 8d        	<unknown>
      5c: 01 45        	<unknown>
      5e: 97 00 00 00  	auipc	ra, 0x0
      62: e7 80 00 00  	jalr	ra, 0x0(ra) <sgemm3+0x5e>
      66: 81 48        	<unknown>
      68: 93 b5 1a 00  	sltiu	a1, s5, 0x1
      6c: 0b a8 05 00  	vx_split	a6, a1
      70: d3 07 00 f0  	fmv.w.x	fa5, zero
      74: dd e1        	<unknown>
      76: a6 80        	<unknown>
      78: 81 4f        	<unknown>
      7a: b3 88 5c 03  	mul	a7, s9, s5
      7e: b3 02 1d 01  	add	t0, s10, a7
      82: b3 05 65 03  	mul	a1, a0, s6
      86: 33 86 a5 01  	add	a2, a1, s10
      8a: 0a 06        	<unknown>
      8c: b3 83 cb 00  	add	t2, s7, a2
      90: 33 0e cc 00  	add	t3, s8, a2
      94: 0a 0d        	<unknown>
      96: 6a 9c        	<unknown>
      98: 93 14 25 00  	slli	s1, a0, 0x2
      9c: 8a 05        	<unknown>
      9e: ae 9b        	<unknown>
      a0: d3 07 00 f0  	fmv.w.x	fa5, zero
      a4: f3 2e 40 cc  	csrrs	t4, tmask, zero
      a8: 09 43        	<unknown>
      aa: 29 a8        	<unknown>
      ac: 0b 30 0f 00  	vx_join	t5
      b0: 0b 40 23 01  	vx_bar	t1, s2
      b4: aa 9f        	<unknown>
      b6: b3 b5 5f 01  	sltu	a1, t6, s5
      ba: 93 c5 15 00  	xori	a1, a1, 0x1
      be: 8b d0 d5 01  	vx_pred_n	a1, t4
      c2: b9 e9        	<unknown>
      c4: b3 85 f2 01  	add	a1, t0, t6
      c8: 8a 05        	<unknown>
      ca: d2 95        	<unknown>
      cc: 98 61        	<unknown>
      ce: 27 a0 e3 00  	fsw	fa4, 0x0(t2)
      d2: b3 85 6f 01  	add	a1, t6, s6
      d6: b3 85 55 03  	mul	a1, a1, s5
      da: ca 95        	<unknown>
      dc: 8a 05        	<unknown>
      de: ce 95        	<unknown>
      e0: 8c 41        	<unknown>
      e2: 33 26 a0 00  	slt	a2, zero, a0
      e6: 6b 40 be 00  	vx_local_sw	a1, 0x0(t3)
      ea: 0b c0 2d 01  	vx_bar	s11, s2
      ee: 0b 2f 16 00  	vx_split_n	t5, a2
      f2: 4d de        	<unknown>
      f4: f3 25 40 cc  	csrrs	a1, tmask, zero
      f8: 5e 87        	<unknown>
      fa: 62 86        	<unknown>
      fc: aa 87        	<unknown>
      fe: 18 63        	<unknown>
     100: 14 62        	<unknown>
     102: c3 77 d7 78  	fmadd.s	fa5, fa4, fa3, fa5, dyn
     106: fd 17        	<unknown>
     108: 26 96        	<unknown>
     10a: 11 07        	<unknown>
     10c: 93 b6 17 00  	sltiu	a3, a5, 0x1
     110: 8b d0 b6 00  	vx_pred_n	a3, a1
     114: ed d6        	<unknown>
     116: 59 bf        	<unknown>
     118: 86 84        	<unknown>
     11a: 0b 30 08 00  	vx_join	a6
     11e: ca 98        	<unknown>
     120: 8a 08        	<unknown>
     122: a6 98        	<unknown>
     124: 27 a0 f8 00  	fsw	fa5, 0x0(a7)
     128: f2 50        	<unknown>
     12a: 62 54        	<unknown>
     12c: d2 54        	<unknown>
     12e: 42 59        	<unknown>
     130: b2 59        	<unknown>
     132: 22 5a        	<unknown>
     134: 92 5a        	<unknown>
     136: 02 5b        	<unknown>
     138: f2 4b        	<unknown>
     13a: 62 4c        	<unknown>
     13c: d2 4c        	<unknown>
     13e: 42 4d        	<unknown>
     140: b2 4d        	<unknown>
     142: 21 61        	<unknown>
     144: 82 80        	<unknown>
