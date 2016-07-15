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

#include <string.h>

void CBootstrap(void) __attribute__ ((section (".startup")));

void CBootstrap(void)
{
   
    /* SBSS */
    extern  char * __sbss_start__;
    extern  char * __sbss_end__;
    
    /* SBSS */
    extern  char * __bss_start__;
    extern  char * __bss_end__;
   
    memset( (char*)&__sbss_start__, 0x0, (size_t)((char*)&__sbss_end__ - (char*)&__sbss_start__) );
    memset( (char*)&__bss_start__,  0x0, (size_t)((char*)&__bss_end__  - (char*)&__bss_start__ ) );

    /* DATA */
    extern  char * __data_flash_start__;
    extern  char * __data_start__;
    /* extern  char * __data_end__; */

    /* SDATA */
    /* extern  char * __sdata_start__; */
    extern  char * __sdata_end__;
    
    memcpy((void *)&__data_start__,  /* DST */
           (const void *)&__data_flash_start__,  /* SRC */
           (size_t)((char*)&__sdata_end__ - (char*)&__data_start__) /* SIZE */);
    
}

