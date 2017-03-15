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
/* See "MPC5746C Reference Manual" Rev 2.1 document number MPC5746CRM */
/* See "Qorivva Recipes for MPC574xG" Rev 1 document number RN4830 */

.global __start

.extern __IVPR_ADDR          /* address base used for IVPR register */

/* load immediate word, 2 instructions needed */
.macro e_lwi reg,val
    e_lis       \reg,\val@H
    e_or2i      \reg,\val@L
.endm

.section .startup, "ax"
.type __start, %function /* needed? */
# Reset vector must be 4 byte aligned
.align 2
__start:

#***************************** Init Core Registers *****************************
    /* GPRs 0-31 */
    e_li        r0, 0
    e_li        r1, 0
    e_li        r2, 0
    e_li        r3, 0
    e_li        r4, 0
    e_li        r5, 0
    e_li        r6, 0
    e_li        r7, 0
    e_li        r8, 0
    e_li        r9, 0
    e_li        r10, 0
    e_li        r11, 0
    e_li        r12, 0
    e_li        r13, 0
    e_li        r14, 0
    e_li        r15, 0
    e_li        r16, 0
    e_li        r17, 0
    e_li        r18, 0
    e_li        r19, 0
    e_li        r20, 0
    e_li        r21, 0
    e_li        r22, 0
    e_li        r23, 0
    e_li        r24, 0
    e_li        r25, 0
    e_li        r26, 0
    e_li        r27, 0
    e_li        r28, 0
    e_li        r29, 0
    e_li        r30, 0
    e_li        r31, 0

    /* Init any other CPU register which might be stacked (before being used). */
    mtspr       1, r1       ;#XER
    mtcrf       0xFF, r1
    mtspr       CTR, r1
    mtspr       272, r1     ;#SPRG0
    mtspr       273, r1     ;#SPRG1
    mtspr       274, r1     ;#SPRG2
    mtspr       275, r1     ;#SPRG3
    mtspr       58, r1      ;#CSRR0
    mtspr       59, r1      ;#CSRR1
    mtspr       570, r1     ;#MCSRR0
    mtspr       571, r1     ;#MCSRR1
    mtspr       61, r1      ;#DEAR
    mtspr       63, r1      ;#IVPR
    mtspr       256, r1     ;#USPRG0
    mtspr       62, r1      ;#ESR
    mtspr       8,r31       ;#LR

#****************************** Disable watchdogs ******************************
    /* Disable SWT0 */
    e_lwi       r6, 0xFC050000
    e_li        r7, 0xC520
    se_stw      r7, 0x10(r6) /* (see MPC5746C RM 2.1 sec 48.4.5) */
    e_li        r7, 0xD928
    se_stw      r7, 0x10(r6) /* Disengage soft-lock for SWT0 */

    e_lwi       r7, 0xFF00000A
    se_stw      r7, 0x0(r6) /* SWT0_CR_WEN = 0  */

    /* reset r6,r7 */
    se_li       r6, 0x0
    se_li       r7, 0x0

#***************************** Initialise SRAM ECC *****************************
# Store number of 128Byte (32GPRs) segments in Counter
    e_lwi       r5, __SRAM_SIZE # Initialize r5 to size of SRAM (Bytes)
    e_srwi      r5, r5, 0x7     # Divide SRAM size by 128
    mtctr       r5              # Move to counter for use with "bdnz"

    # Base Address of the internal SRAM
    e_lwi       r5, __SRAM_BASE_ADDR

# Fill SRAM with writes of 32GPRs
sram_loop:
    e_stmw      r0,0(r5)    # Write all 32 registers to SRAM
    e_addi      r5,r5,128   # Increment the RAM pointer to next 128bytes
    e_bdnz      sram_loop   # Loop for all of SRAM

#************* Enable critical input and machine check exception ***************
    e_lwi       r4, 0x21000 /* (see MPC5746C RM Rev 2.1 sec 61.8.2) */
    mfmsr       r3
    se_or       r3, r4
    mtmsr       r3

    /* FXIME: Qorivva Recipes for MPC574xG section 3.1 says to */
    /* "Set IVPR = start of SRAM" here - why? */

#****************** Invalidate and Enable the Instruction cache ****************
__icache_cfg:
    e_li        r5, 0x2
    mtspr       1011,r5

    e_li        r7, 0x4
    e_li        r8, 0x2
    e_lwi       r11, 0xFFFFFFFB

__icache_inv:
    mfspr       r9, 1011
    and.        r10, r7, r9
    e_beq       __icache_no_abort
    and.        r10, r11, r9
    mtspr       1011, r10
    e_b         __icache_cfg

__icache_no_abort:
    and.        r10, r8, r9
    e_bne       __icache_inv

    mfspr       r5, 1011
    e_ori       r5, r5, 0x0001
    se_isync
    ;#msync
    mtspr       1011, r5

#******************** Invalidate and Enable the Data cache *********************

__dcache_cfg:
    e_li        r5, 0x2
    mtspr       1010,r5

    e_li        r7, 0x4
    e_li        r8, 0x2
    e_lwi       r11, 0xFFFFFFFB

__dcache_inv:
    mfspr       r9, 1010
    and.        r10, r7, r9
    e_beq       __dcache_no_abort
    and.        r10, r11, r9
    mtspr       1010, r10
    e_b         __dcache_cfg

__dcache_no_abort:
    and.        r10, r8, r9
    e_bne       __dcache_inv

    mfspr       r5, 1010
    e_ori       r5, r5, 0x0001
    se_isync
    msync
    mtspr       1010, r5

#************************ Enable branch target prefetching *********************
    /* Flush & Enable BTB - Set BBFI and BPEN in BUCSR */
    e_li        r3, 0x201
    mtspr       1013, r3
    se_isync

#******************** Clear reservations on external interrupt *****************
    /* Set ICR in HID0 */
    e_lwi       r3, 0x20000
    mtspr       1008, r3
    se_isync

#****************************** Configure Stack ********************************
    e_lwi       r1,  __SP_INIT__ ;# Initialize stack pointer r1 to value in linker command file.
    e_lwi       r13, _SDA_BASE_  ;# Initialize r13 to sdata base (provided by linker).
    e_lwi       r2,  _SDA2_BASE_ ;# Initialize r2 to sdata2 base (provided by linker).

    e_li        r0, 0xFFFF@l /* load up r0 with 0xFFFFFFFF */
    e_stwu      r0,-8(r1)    /* Create a root frame header to terminate stack */
    e_stw       r0, 4(r1)    /* Make an illegal return address of 0xFFFFFFFF */
    e_stw       r0, 0(r1)    /* Make an illegal back chain address of 0xFFFFFFFF */

#****************************** Interrupts setup *******************************
    e_lwi       r3, __IVPR_ADDR
    mtIVPR      r3

#****************************** Memory controller setup ************************
#    e_lwi       r3, memory_config
#    mtlr        r3
#    se_blrl
#
#****************************** Clock setup ************************************
#    e_lwi       r3, clock_config
#    mtlr        r3
#    se_blrl
#
#****************************** Prepare C environment **************************
    e_lwi       r3, CBootstrap
    mtlr        r3
    se_blrl

#****************************** Prepare C++ environment ************************
#    e_lwi       r3, init_cpp
#    mtlr        r3
#    se_blrl
#
#****************************** Jump to Main ***********************************
    e_b         main
