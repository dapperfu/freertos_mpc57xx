#ifndef HW_WDG_H
#define HW_WDG_H
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


/******************************************************************** Watchdog ********************************************************************/

#define SWT0_SR_R  HWREG32(HWSWT0_BASE_ADDR + 0x10)
#define SWT0_CR_R  HWREG32(HWSWT0_BASE_ADDR)

/** Access the WatchDog only from the first CPU, the others might not have access to SWT0 **/
#define HWWatchdogDisable() do {              \
        SWT0_SR_R = 0xc520;                   \
        SWT0_SR_R = 0xd928;                   \
        SWT0_CR_R = 0x8000010A;               \
} while (0)


#ifdef __cplusplus
}
#endif

#endif  /* HW_WDG_H */

