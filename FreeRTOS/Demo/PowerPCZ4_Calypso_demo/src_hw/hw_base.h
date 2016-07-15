#ifndef HW_BASE_H
#define HW_BASE_H
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

/* peripheral base addresses */

#define HWGCM_BASE_ADDR    (0xFFFB0000UL)
#define HWGPIO_BASE_ADDR   (0xFFFC0000UL)
#define HWINTC_BASE_ADDR   (0xFC040000UL)
#define HWME_BASE_ADDR     (0xFFFB8000UL)
#define HWPIT_BASE_ADDR    (0xFFF84000UL)
#define HWRGM_BASE_ADDR    (0xFFFA8000UL)
#define HWSWT0_BASE_ADDR   (0xFC050000UL)


#ifdef __cplusplus
}
#endif

#endif  /* HW_BASE_H */

