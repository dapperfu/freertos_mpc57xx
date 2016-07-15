#ifndef _TYPEDEFS_H_
#define _TYPEDEFS_H_

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


#include "stdint.h"

    /* hw register access macros */
    #define HWREG32(address) (*(volatile unsigned int   *)(address)) /* 32-bit register */
    #define HWREG16(address) (*(volatile unsigned short *)(address)) /* 16-bit register */
    #define HWREG8(address)  (*(volatile unsigned char  *)(address)) /*  8-bit register */
    
    typedef volatile signed char vint8_t;
    typedef volatile unsigned char vuint8_t;

    typedef volatile signed short vint16_t;
    typedef volatile unsigned short vuint16_t;

    typedef volatile signed int vint32_t;
    typedef volatile unsigned int vuint32_t;


#endif
