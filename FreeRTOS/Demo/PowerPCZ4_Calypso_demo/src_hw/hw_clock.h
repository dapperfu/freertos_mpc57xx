#ifndef HW_CLOCK_H
#define HW_CLOCK_H
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


#ifdef __cplusplus
extern "C"
{
#endif

#include "hw_typedefs.h"
#include "hw_base.h"


/******************************************************************** Clocks ********************************************************************/

/* Reset generation module */
#define HWRGM_FES    HWREG16(HWRGM_BASE_ADDR)            /* Functional Event Status */

#define CGM_SC_DC0_3 HWREG32(HWGCM_BASE_ADDR + 0x07E8U)  /* System Clock Divider Configuration Registers (CGM_SC_DC0:3) */
#define ME_GS        HWREG32(HWME_BASE_ADDR)             /* Global Status Register */
#define ME_RUN_PC    HWREG32(HWME_BASE_ADDR + 0x80U)     /* Run Peripheral Configuration Registers MC_ME_RUN_PC0 */
#define ME_MCTL      HWREG32(HWME_BASE_ADDR + 0x4U)      /* Mode Control Register */

#define MC_ME_CCTL(coreId) \
    (HWREG16(HWME_BASE_ADDR + 0x1C6 + ((coreId) << 1U))) /* Core Control Register for core with given coreId */

#define HWPeriphEnableAll()                                                    \
{                                                                              \
    HWRGM_FES = 0x4080;              /* clear fccr_hard and fccu_safe flags */ \
    CGM_SC_DC0_3 = 0x80000000;       /* Divider 2 Enable,DIV0 = 1 */           \
    ME_RUN_PC = 0x000000FE;          /* Set configuration,peripheral ON in every mode */ \
    ME_MCTL = 0x30005AF0;            /* Re-enter in DRUN mode to update with control key */ \
    ME_MCTL = 0x3000A50F;            /* --//-- with inverted control key */ \
    while(ME_GS & 0x08000000ul){}    /* Wait for mode transition to complete */ \
    while((ME_GS & 0x30000000ul) != 0x30000000ul){}     /* Check current mode status is DRUN */ \
}



#ifdef __cplusplus
}
#endif

#endif  /* HW_CLOCK_H */

