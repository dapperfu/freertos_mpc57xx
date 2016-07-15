#ifndef PLATFORM_H
#define PLATFORM_H
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

#include "hw_clock.h"
#include "hw_gpio.h"
#include "hw_intc.h"
#include "hw_pit.h"
#include "hw_wdg.h"


/* interrupt handlers type */
typedef void(*OSInterruptHandlerPtr)(void);

/* for unused/unexpected interrupts */
extern void OS_UnusedInterruptHandler(void);

extern void OS_InstallInterruptHandler(OSInterruptHandlerPtr handlerFn, unsigned int vectorNum, unsigned char Priority);
extern void OS_DisableINTCInput (unsigned int vectorNum);

extern void OS_PlatformInit(void);


#ifdef __cplusplus
}
#endif

#endif /* PLATFORM_H */

