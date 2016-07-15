#ifndef HW_GPIO_H
#define HW_GPIO_H
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

/******************************************************************** GPIO ********************************************************************/
/* NOTE: GPIO_NUM is connected to LED0 on EVB motherboard */

#define LED0    0U
#define LED1    1U
#define LED2    2U
#define LED3    3U

#define GPIO_NUM         24U
#define GPIO_MSCR_NUM    98U

#define SIUL2_MSCR(n)  HWREG32(HWGPIO_BASE_ADDR + 0x240 + GPIO_MSCR_NUM * 4 + (n) * 4)      /* SIUL2 Multiplexed Signal Configuration Register */
#define SIUL2_GPDO(n)  HWREG8(HWGPIO_BASE_ADDR + 0x1300 + GPIO_NUM * 4 + 2 + (n))           /* Pad Data Output Register */
#define SIUL_MSCR      0x02000000ul              /* GPIO Output Buffer Enable */

#define SetGPIO(n)    SIUL2_GPDO(n)  = 0x1       /* set pin GPIO_NUM */
#define ClrGPIO(n)    SIUL2_GPDO(n)  = 0x0       /* reset pin GPIO_NUM */
#define ToogleGPIO(n) SIUL2_GPDO(n) ^= 0x1       /* toogle pin GPIO_NUM */

#define InitGPIO(n)                 \
        SIUL2_MSCR(n) = SIUL_MSCR;  \
        ClrGPIO(n)



#ifdef __cplusplus
}
#endif

#endif  /* HW_GPIO_H */

