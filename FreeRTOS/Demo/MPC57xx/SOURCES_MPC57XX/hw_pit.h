#ifndef HW_PIT_H
#define HW_PIT_H
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
extern "C" {
#endif

#include "hw_typedefs.h"
#include "hw_base.h"


#define HWPIT_MCR           HWREG32(HWPIT_BASE_ADDR)           /* PIT Module Control Register */

#define HWPIT_RTI_LDVAL     HWREG32(HWPIT_BASE_ADDR + 0xF0U)   /* PIT_RTI Timer Load Value Register */
#define HWPIT_RTI_CVAL      HWREG32(HWPIT_BASE_ADDR + 0xF4U)   /* PIT_RTI Timer Current Timer Value Register */
#define HWPIT_RTI_TCTRL     HWREG32(HWPIT_BASE_ADDR + 0xF8U)   /* PIT_RTI Timer Control Register */
#define HWPIT_RTI_TFLG      HWREG32(HWPIT_BASE_ADDR + 0xFCU)   /* PIT_RTI Timer Flag Register */

#define HWPIT_LDVAL(chid)   HWREG32(HWPIT_BASE_ADDR + 0x100U + 16U*(chid))   /* PIT Timer Load Value Register */
#define HWPIT_CVAL(chid)    HWREG32(HWPIT_BASE_ADDR + 0x104U + 16U*(chid))   /* PIT Timer Current Timer Value Register */
#define HWPIT_TCTRL(chid)   HWREG32(HWPIT_BASE_ADDR + 0x108U + 16U*(chid))   /* PIT Timer Control Register */
#define HWPIT_TFLG(chid)    HWREG32(HWPIT_BASE_ADDR + 0x10CU + 16U*(chid))   /* PIT Timer Flag Register */

#define HWPIT_MCR_FRZ       (unsigned int)0x00000001U
#define HWPIT_MCR_MDIS      (unsigned int)0x00000002U
#define HWPIT_MCR_MDIS_RIT  (unsigned int)0x00000004U

#define HWPIT_TCTRL_TEN     (unsigned int)0x00000001U
#define HWPIT_TCTRL_TIE     (unsigned int)0x00000002U

#define HWPIT_TFLG_TIF      (unsigned int)0x00000001U


#if ((configUSE_PIT_CHANNEL<0) || (configUSE_PIT_CHANNEL>15))
#error "configUSE_PIT_CHANNEL parameter out of range: use [0..15]"
#endif

#define HWPIT_GET_INTID(chid) (unsigned int)(chid + 226U)


#ifdef  __cplusplus
}
#endif

#endif /* HW_PIT_H */


