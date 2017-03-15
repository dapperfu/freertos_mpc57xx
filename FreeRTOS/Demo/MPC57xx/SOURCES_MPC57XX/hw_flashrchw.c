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


#define CPU2_ENABLE   0x00000001  /* CPU2 is enabled              */
#define CPU0_ENABLE   0x00000002  /* CPU0 is enabled              */
#define MPC574xx_ID   0x005A0000  /* RCHW boot ID for MPC574xx devices    */
#define RCHW_VAL (CPU0_ENABLE | MPC574xx_ID)

extern void __start(void);

#define RCHWDATA __attribute__((section(".rchwdata")))


RCHWDATA const unsigned int RCHW6=0x00;
RCHWDATA const unsigned int RCHW5=(const unsigned int)__start; /* entry point */
RCHWDATA const unsigned int RCHW4=0x00;
RCHWDATA const unsigned int RCHW3=0x00;
RCHWDATA const unsigned int RCHW2=0x00;
RCHWDATA const unsigned int RCHW1=RCHW_VAL;



