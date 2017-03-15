/*==================================================================================================
*
*   (c) Copyright 2015 Freescale Semiconductor Inc.
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



  .equiv SRAM_BASE_ADDR, 0x40000000
  .equiv SRAM_LOOP_SIZE, (512*1024)>>7


  .global __start
  .global   prep_flash_startup

  .extern __IVPR_ADDR        # address base used for IVPR register


  # load immediate word, 2 instructions needed
  .macro    e_lwi    reg,val
      e_lis    \reg,\val@H
      e_or2i   \reg,\val@L
  .endm


  .section ".startup","ax"

# entry point
.type __start, %function
__start:

    # ----------------- clear regs
    se_li r0, 0
    se_li r1, 0
    se_li r2, 0
    se_li r3, 0
    se_li r4, 0
    se_li r5, 0
    se_li r6, 0
    se_li r7, 0

    e_li  r8, 0
    e_li  r9, 0
    e_li  r10, 0
    e_li  r11, 0
    e_li  r12, 0
    e_li  r13, 0
    e_li  r14, 0
    e_li  r15, 0
    e_li  r16, 0
    e_li  r17, 0
    e_li  r18, 0
    e_li  r19, 0
    e_li  r20, 0
    e_li  r21, 0
    e_li  r22, 0
    e_li  r23, 0

    se_li r24, 0
    se_li r25, 0
    se_li r26, 0
    se_li r27, 0
    se_li r28, 0
    se_li r29, 0
    se_li r30, 0
    se_li r31, 0


    se_bl prep_flash_startup
    
    #--------------------- setup Stack, SDA and SDA2 base register pointers
    e_lis     r1, __SP_INIT__@ha
    e_add16i  r1, r1, __SP_INIT__@l
    e_add16i  r1, r1, -0x8

    # if small data are present GCC will generate
    # _SDA_BASE_ that will == with __sdata_start__
    # for .sdata
    e_lis     r13, __sdata_start__@ha
    e_add16i  r13, r13, __sdata_start__@l

    # equivalent to _SDA2_BASE_ used for .sdata2
    e_lis     r2, __sdata2_start@ha
    e_add16i  r2, r2, __sdata2_start@l

    # Clear r0, Terminate stack
    e_andi     r0,r0,0           
    e_stwu     r0,-64(r1)        


    # -------------------- setup Branch Unit Control
    # Flush BTB - Set BBFI bit in BUCSR
    e_li r3, 0x200
    mtspr 1013, r3

    # Enable BTB - Set BPEN bit in BUCSR
    se_li r3, 0x1
    mtspr 1013, r3



    # -------------------- Interrupts setup
    # IVPR = address base
    e_lwi r3, __IVPR_ADDR
    mtIVPR r3


    # enable critical input and machine check exception
    #e_lwi   r4, 0x21000
    #mfmsr   r3

    #se_or   r3, r4
    #mtmsr   r3



    # -------------------------- prepare a terminating stack record
    e_li    0, 0xFFFF@l # load up r0 with 0xFFFFFFFF
    e_stwu r1, -16(r1)  # Decrement stack by 16 bytes, (write word)
    e_stw  r0, 4(r1)    # Make an illegal return address of 0xFFFFFFFF
    e_stw  r0, 0(r1)    # Make an illegal back chain address of 0xFFFFFFFF


    # -------------------------- prepare C environment
    e_lwi r3, CBootstrap
    mtlr  r3
    se_blrl


    # -------------------------- branch to main program
    e_lwi r3, main
    mtlr  r3
    se_blrl

__return_from_main:
    se_b __return_from_main /* loop here in case main returns */

.size __start, . - __start
    
.type prep_flash_startup, %function
prep_flash_startup:                               

    /* Disable SWT0 */
    e_lis     r6,0xFC05
    e_or2i    r6,0x0010
    e_li      r7,0xC520
    se_stw    r7,0x0(r6)
    e_li      r7,0xD928
    se_stw    r7,0x0(r6) /* Disengage soft-lock for SWT0 */

    e_lis     r6,0xFC05
    e_lis     r7,0xFF00
    e_or2i    r7,0x000A
    se_stw    r7,0x0(r6) /* SWT0_CR_WEN = 0  */

    /* Disable SWT1 */
    e_lis     r6,0xFC05
    e_or2i    r6,0x4010
    e_li      r7,0xC520
    se_stw    r7,0x0(r6)
    e_li      r7,0xD928
    se_stw    r7,0x0(r6) /* Disengage soft-lock for SWT1 */

    e_lis     r6,0xFC05
    e_or2i    r6,0x4000
    e_lis     r7,0xFF00
    e_or2i    r7,0x000A
    se_stw    r7,0x0(r6) /* SWT1_CR_WEN = 0  */

    /* reset r6,r7 */
    se_li     r6, 0x0
    se_li     r7, 0x0
    
/* Code to initialize all internal RAM.
   This must be executed before using RAM to avoid ECC errors. */

   e_lis r11,SRAM_BASE_ADDR@h   /* Base address of the SRAM, 64-bit word aligned */
   e_li r12,SRAM_LOOP_SIZE      /* Loop counter to get all of SRAM; SIZE/4 bytes/32 GPRs */
   mtctr r12
   e_li  r12, 0                 /* more zeroes */

init_sram_loop:               
   e_stmw r0,0(r11)             /* Write 32 GPRs to SRAM */
   e_addi r11,r11,128           /* Inc the ram ptr; 32 GPRs * 4 bytes = 128 */
   e_bdnz init_sram_loop        /* Branch SRAM_LOOP_SIZE-1 times */
   
   
   se_blr                       

.size prep_flash_startup, . - prep_flash_startup
   
    
  # end of assembler code
  .end

  