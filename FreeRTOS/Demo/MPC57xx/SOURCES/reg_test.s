/*==================================================================================================
*
*   (c) Copyright 2016 Freescale Semiconductor Inc.
*   
*   This program is free software; you can redistribute it and/or modify it under
*   the terms of the GNU General Public License (version 2) as published by the
*   Free Software Foundation >>>> AND MODIFIED BY <<<< the FreeRTOS exception.
*
*   ***************************************************************************
*   >>!   NOTE: The modification to the GPL is included to allow you to     !<<
*   >>!   distribute a combined work that includes FreeRTOS without being   !<<
*   >>!   obliged to provide the source code for proprietary components     !<<
*   >>!   outside of the FreeRTOS kernel.                                   !<<
*   ***************************************************************************
*
*   This program is distributed in the hope that it will be useful,
*   but WITHOUT ANY WARRANTY; without even the implied warranty of
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*   GNU General Public License for more details.
*   
*   You should have received a copy of the GNU General Public License
*   along with this program; if not, write to the Free Software
*   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*
==================================================================================================*/

	.extern ulRegTest1LoopCounter
	.extern ulRegTest2LoopCounter

	.text
	.global vRegTest1Implementation
	.type vRegTest1Implementation, %function
vRegTest1Implementation:
    se_li r31, 31
	se_li r30, 30
	se_li r29, 29
	se_li r28, 28
	se_li r27, 27
	se_li r26, 26
	se_li r25, 25
	se_li r24, 24
	e_li r23, 23
	e_li r22, 22
	e_li r21, 21
	e_li r20, 20
	e_li r19, 19
	e_li r18, 18
	e_li r17, 17
	e_li r16, 16
	e_li r15, 15
	e_li r14, 14
#	e_li r13, 13 #-- reg13 _SDA_BASE
	e_li r12, 12
	e_li r11, 11
	e_li r10, 10
	e_li r9, 9
	e_li r8, 8
	se_li r7, 7
	se_li r6, 6
	se_li r5, 5
	se_li r4, 4
	se_li r3, 33
	mtlr r3
	se_li r3, 34
	mtxer r3
	se_li r3, 35
	mtcr r3
	se_li r3, 36
	mtctr r3
	se_li r3, 3
#	se_li r2, 2 #-- _SDA2_BASE
#	se_li r1, 1 #-- stack pointer
	se_li r0, 32
	
loopTest1:
	e_stwu r3, -12(r1)			#save R3
	se_stw r4, 4(r1)			#save R4
	mfcr r3
	se_stw r3, 8(r1)			#save CR
	se_li r3, 0
	se_sc
	se_nop

	se_lwz r3, 8(r1)
	mtcr r3
	e_cmpi cr1, r3, 35			#R3 <- CR
	e_bne cr1, errorCmp1
	mflr r3						#lr
	e_cmpi cr1, r3, 33
	e_bne cr1, errorCmp1
	mfxer r3					#xer
	e_cmpi cr1, r3, 34
	e_bne cr1, errorCmp1
	mfctr r3					#ctr
	e_cmpi cr1, r3, 36
	e_bne cr1, errorCmp1
	se_lwz  r3, 0(r1)			#restore R3

	e_cmpi cr1, r31, 31
	e_bne cr1, errorCmp1
	e_cmpi cr1, r30, 30
	e_bne cr1, errorCmp1
	e_cmpi cr1, r29, 29
	e_bne cr1, errorCmp1
	e_cmpi cr1, r28, 28
	e_bne cr1, errorCmp1
	e_cmpi cr1, r27, 27
	e_bne cr1, errorCmp1
	e_cmpi cr1, r26, 26
	e_bne cr1, errorCmp1
	e_cmpi cr1, r25, 25
	e_bne cr1, errorCmp1
	e_cmpi cr1, r24, 24
	e_bne cr1, errorCmp1
	e_cmpi cr1, r23, 23
	e_bne cr1, errorCmp1
	e_cmpi cr1, r22, 22
	e_bne cr1, errorCmp1
	e_cmpi cr1, r21, 21
	e_bne cr1, errorCmp1
	e_cmpi cr1, r20, 20
	e_bne cr1, errorCmp1
	e_cmpi cr1, r19, 19
	e_bne cr1, errorCmp1
	e_cmpi cr1, r18, 18
	e_bne cr1, errorCmp1
	e_cmpi cr1, r17, 17
	e_bne cr1, errorCmp1
	e_cmpi cr1, r16, 16
	e_bne cr1, errorCmp1
	e_cmpi cr1, r15, 15
	e_bne cr1, errorCmp1
	e_cmpi cr1, r14, 14
	e_bne cr1, errorCmp1
#	e_cmpi cr1, r13, 13
#	e_bne cr1, errorCmp1
	e_cmpi cr1, r12, 12
	e_bne cr1, errorCmp1
	e_cmpi cr1, r11, 11
	e_bne cr1, errorCmp1
	e_cmpi cr1, r10, 10
	e_bne cr1, errorCmp1
	e_cmpi cr1, r9, 9
	e_bne cr1, errorCmp1
	e_cmpi cr1, r8, 8
	e_bne cr1, errorCmp1
	e_cmpi cr1, r7, 7
	e_bne cr1, errorCmp1
	e_cmpi cr1, r6, 6
	e_bne cr1, errorCmp1
	e_cmpi cr1, r5, 5
	e_bne cr1, errorCmp1
	e_cmpi cr1, r4, 4
	e_bne cr1, errorCmp1
	e_cmpi cr1, r3, 3
	e_bne cr1, errorCmp1
#	e_cmpi cr1, r2, 2
#	e_bne cr1, errorCmp1
#	e_cmpi cr1, r1, 1
#	e_bne cr1, errorCmp1
	e_cmpi cr1, r0, 32
	e_bne cr1, errorCmp1
	
	e_lis r3, ulRegTest1LoopCounter@HA
	e_lwz     r4, ulRegTest1LoopCounter@L(r3)
#	e_ori r3, r3, ulRegTest1LoopCounter@L
#	se_lwz r4, 0(r3)
	e_addi r4, r4, 1
	e_stw r4, ulRegTest1LoopCounter@L(r3)

	se_lwz  r3, 8(r1)		#get CR
	mtcr r3
	se_lwz  r4, 4(r1)
	se_lwz  r3, 0(r1)
	e_addi  r1, r1, 12
	e_b loopTest1
errorCmp1:
	se_b errorCmp1

	/* Should not get here! */
    se_blr

  .global vRegTest2Implementation
  .type vRegTest2Implementation, %function
vRegTest2Implementation:
    se_li r31, 1
	se_li r30, 2
	se_li r29, 3
	se_li r28, 4
	se_li r27, 5
	se_li r26, 6
	se_li r25, 7
	se_li r24, 8
	e_li r23, 9
	e_li r22, 10
	e_li r21, 11
	e_li r20, 12
	e_li r19, 13
	e_li r18, 14
	e_li r17, 15
	e_li r16, 16
	e_li r15, 17
	e_li r14, 18
#	e_li r13, 19 #-- reg13 _SDA_BASE
	e_li r12, 20
	e_li r11, 21
	e_li r10, 22
	e_li r9, 23
	e_li r8, 24
	se_li r7, 25
	se_li r6, 26
	se_li r5, 27
	se_li r4, 28
	se_li r3, 34
	mtlr r3
	se_li r3, 44
	mtxer r3
	se_li r3, 45
	mtcr r3
	se_li r3, 46
	mtctr r3
	se_li r3, 29
#	se_li r2, 30 #-- _SDA2_BASE
#	se_li r1, 31 #-- stack pointer
	se_li r0, 33
	
loopTest2:
	e_stwu r3, -12(r1)			#save R3
	se_stw r4, 4(r1)			#save R4
	mfcr r3
	se_stw r3, 8(r1)			#save CR
	se_li r3, 0
	se_sc
	se_nop
	
	se_lwz r3, 8(r1)
	mtcr r3
	e_cmpi cr1, r3, 45			#R3 <- CR
	e_bne cr1, errorCmp2
	mflr r3						#lr
	e_cmpi cr1, r3, 34
	e_bne cr1, errorCmp2
	mfxer r3					#xer
	e_cmpi cr1, r3, 44
	e_bne cr1, errorCmp2
	mfctr r3					#ctr
	e_cmpi cr1, r3, 46
	e_bne cr1, errorCmp2
	se_lwz  r3, 0(r1)			#restore R3
	
	e_cmpi cr1, r31, 1
	e_bne cr1, errorCmp2
	e_cmpi cr1, r30, 2
	e_bne cr1, errorCmp2
	e_cmpi cr1, r29, 3
	e_bne cr1, errorCmp2
	e_cmpi cr1, r28, 4
	e_bne cr1, errorCmp2
	e_cmpi cr1, r27, 5
	e_bne cr1, errorCmp2
	e_cmpi cr1, r26, 6
	e_bne cr1, errorCmp2
	e_cmpi cr1, r25, 7
	e_bne cr1, errorCmp2
	e_cmpi cr1, r24, 8
	e_bne cr1, errorCmp2
	e_cmpi cr1, r23, 9
	e_bne cr1, errorCmp2
	e_cmpi cr1, r22, 10
	e_bne cr1, errorCmp2
	e_cmpi cr1, r21, 11
	e_bne cr1, errorCmp2
	e_cmpi cr1, r20, 12
	e_bne cr1, errorCmp2
	e_cmpi cr1, r19, 13
	e_bne cr1, errorCmp2
	e_cmpi cr1, r18, 14
	e_bne cr1, errorCmp2
	e_cmpi cr1, r17, 15
	e_bne cr1, errorCmp2
	e_cmpi cr1, r16, 16
	e_bne cr1, errorCmp2
	e_cmpi cr1, r15, 17
	e_bne cr1, errorCmp2
	e_cmpi cr1, r14, 18
	e_bne cr1, errorCmp2
#	e_cmpi cr1, r13, 19
#	e_bne cr1, errorCmp2
	e_cmpi cr1, r12, 20
	e_bne cr1, errorCmp2
	e_cmpi cr1, r11, 21
	e_bne cr1, errorCmp2
	e_cmpi cr1, r10, 22
	e_bne cr1, errorCmp2
	e_cmpi cr1, r9, 23
	e_bne cr1, errorCmp2
	e_cmpi cr1, r8, 24
	e_bne cr1, errorCmp2
	e_cmpi cr1, r7, 25
	e_bne cr1, errorCmp2
	e_cmpi cr1, r6, 26
	e_bne cr1, errorCmp2
	e_cmpi cr1, r5, 27
	e_bne cr1, errorCmp2
	e_cmpi cr1, r4, 28
	e_bne cr1, errorCmp2
	e_cmpi cr1, r3, 29
	e_bne cr1, errorCmp2
#	e_cmpi cr1, r2, 30
#	e_bne cr1, errorCmp2
#	e_cmpi cr1, r1, 31
#	e_bne cr1, errorCmp2
	e_cmpi cr1, r0, 33
	e_bne cr1, errorCmp2

	e_bne cr1, errorCmp2
	e_lis r3, ulRegTest2LoopCounter@HA
	e_lwz     r4, ulRegTest2LoopCounter@L(r3)
#	e_ori r3, r3, ulRegTest2LoopCounter@L
#	se_lwz r4, 0(r3)
	e_addi r4, r4, 1
	e_stw r4, ulRegTest2LoopCounter@L(r3)

	se_lwz  r3, 8(r1)		#get CR
	mtcr r3
	se_lwz  r4, 4(r1)
	se_lwz  r3, 0(r1)
	e_addi  r1, r1, 12
	e_b loopTest2
errorCmp2:
	se_b errorCmp2

	/* Should not get here! */
    se_blr

  # end of assembler code
  .end

  