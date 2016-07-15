#ifndef HW_INTC_H
#define HW_INTC_H
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

    #define HWINTC_INTERRUPTS    (766U)
    
    #define HWINTC_OFFSET        (0x0U) /* can be used to access the INTC registers for the other cores, for Z4 it's 0 */
    
    #define HWINTC_MCR           HWREG32(HWINTC_BASE_ADDR)                            /* Module/Block Configuration Register */
    #define HWINTC_CPR           HWREG32(HWINTC_BASE_ADDR + 0x10U + HWINTC_OFFSET)    /* Current Priority Register */
    #define HWINTC_IACKR         HWREG32(HWINTC_BASE_ADDR + 0x20U + HWINTC_OFFSET)    /* Interrupt Acknowledge Register */
    #define HWINTC_EOIR          HWREG32(HWINTC_BASE_ADDR + 0x30U + HWINTC_OFFSET)    /* End of Interrupt Register */
    #define HWINTC_SSCIR(intr)   HWREG8(HWINTC_BASE_ADDR  + 0x40U + (intr))           /* Software Set/Clear Interrupt Register
                                                                                         for setable software interrupt (n) */
                                                                                         
    #define HWINTC_SOFTINVOKE    (0x2U)                                               /* bit number to invoke setable software interrupt */
    #define HWINTC_SOFTCLEAR     (0x1U)                                               /* bit number to clear setable software interrupt */

    #define HWINTC_PSR_ADDR(intr) (HWINTC_BASE_ADDR + 0x60U + (unsigned int)((intr)<<1U))  /* address of INTC_PSR for intr input */

    #define HWINTC_PSR(intr)       HWREG16( HWINTC_PSR_ADDR(intr) )            /* INTC_PSR register for intr input */
    #define HWINTC_PRIO(intr)      HWREG8(  HWINTC_PSR_ADDR(intr) + 1U)        /* Priority select register for intr input */
    #define HWINTC_PRC_SEL(intr)   HWREG8(  HWINTC_PSR_ADDR(intr)  )           /* Processor select bits' registor for intr input */


    /* Set priority, given prio must contain only priority */
    #define HWINTC_SET_PSRX(intr, prio) (HWINTC_PRIO(intr) = (prio))

    #define HWINTC_GET_PSRX(intr) (HWINTC_PRIO(intr))                                 /* Return current prio for intr input */

    /* Hardware vector mode bit */
    #define HWINTC_MCR_HVEN(coreId)   ( (OSDWORD) (0x1UL << ((coreId) << 4UL)) )      /* coreId - hw coreId (value that is read from PIR) */


#ifdef __cplusplus
}
#endif


#endif /* HW_INTC_H */


