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
/* Address of INTC_IACK0 register */
	.equ INTC_IACKR_PRC0_ADDR, 0xFC040020

/* Number of bits in the INTVEC field of IACKR */
	.equ INTC_IACKR_INTVEC_BITWIDTH,10

/* Address of INTC_EOIR0 register */
	.equ INTC_EOIR_PRC0_ADDR,0xFC040030

/* SPV enables floating point on 574x */
	.equ MSR_FPU_ENABLE_BIT,25

/* Address of the INTC_CPR0 register */
	.equ INTC_CPR0_ADDR,0xFC040010
