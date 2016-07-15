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

#include "hw_platform.h"
#include "hw_intc.h"


/* Macro to calculate bit value for given INTC input */
#define OSINTCInputBit(n) ( (unsigned int)(OsINTCInputs[(n)/8U] >> ((n)%8U)) & 0x1U )


OSInterruptHandlerPtr OSInterruptsHandlerTable[ HWINTC_INTERRUPTS ];


/* INTC has some unimplemented inputs (the registers PSR, PRC_SEL are not
   implemented for these inputs). Following array contains bit set where
   each bit corresponds to an INTC input with number of the bit.
   If the value of bit is 1 - INTC input is implemented, 0 - INTC input is
   not implemented */
const unsigned char OsINTCInputs[ HWINTC_INTERRUPTS ] = {
    0xff, 0xff, 0xff, 0x00, 0xf3, 0x0f, 0xf0, 0xff, /*   0.. 63 */
    0xff, 0xff, 0x1f, 0x00, 0x00, 0x00, 0x00, 0x00, /*  64..127 */
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, /* 128..191 */
    0x00, 0x00, 0xfc, 0x07, 0xff, 0xff, 0x7f, 0xfc, /* 192..255 */
    0xfe, 0xff, 0xff, 0xff, 0xff, 0x7f, 0xff, 0xfe, /* 256..319 */
    0xfd, 0x03, 0x00, 0x00, 0x00, 0x00, 0x30, 0xff, /* 320..383 */
    0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x55, /* 384..447 */
    0xe0, 0x7f, 0x00, 0x00, 0x11, 0x07, 0xff, 0xff, /* 448..511 */
    0xff, 0xff, 0x00, 0x00, 0x70, 0x1c, 0xe7, 0x7f, /* 512..575 */
    0xfc, 0xc7, 0x7f, 0xfc, 0xc7, 0x7f, 0xfc, 0xc7, /* 576..639 */
    0x7f, 0xfc, 0x07, 0xf0, 0x00, 0x00, 0xfc, 0x60, /* 640..703 */
    0xfc, 0xff, 0xff, 0xff, 0x03, 0x00, 0xfc, 0x3f  /* 704..765 */
};




void OS_UnusedInterruptHandler(void)
{
    while(1);
}


/******************************************************************************
 * Function:    OSDisableINTCInput
 * Description: Disables INTC input if implemented
 * Returns:     none
 * Notes:
 ******************************************************************************/
void OS_DisableINTCInput (unsigned int vectorNum)
{
    
    if ((vectorNum >= HWINTC_INTERRUPTS) || (OSINTCInputBit(vectorNum) == 0U))
    {
        /* INTC input with given number is not implemented */
        return;
    }
    
    HWINTC_SET_PSRX(vectorNum,0x0); /* prio level 0 */

    return;
}


/**
 * This function can be used to install an interrupt handler for a given
 * interrupt vector. It will also set the Priority Status Register for the
 * source to the one given
 */

void OS_InstallInterruptHandler(OSInterruptHandlerPtr handlerFn, unsigned int vectorNum, unsigned char Priority)
{

    if ((vectorNum >= HWINTC_INTERRUPTS) || (OSINTCInputBit(vectorNum) == 0U))
    {
        /* INTC input with given number is not implemented */
        return;
    }

    /* Set the function pointer in the ISR Handler table */
    OSInterruptsHandlerTable[vectorNum] = handlerFn;

    /* select Core0 as interrupt destination and set the priority */
    HWINTC_PSR(vectorNum) = (short unsigned int)((short unsigned int)0x8000 | (short unsigned int)Priority);
    
}




void OS_PlatformInit(void)
{
    unsigned int i;

    /* clean interrupt controller */
    for (i=0; i<HWINTC_INTERRUPTS; i++)
    {
        OSInterruptsHandlerTable[ i ] = OS_UnusedInterruptHandler;
        OS_DisableINTCInput(i);
    }

    HWINTC_MCR = HWINTC_MCR & 0xFFFFFFF0UL; /* clear HVEN0 - software mode */
    
    HWINTC_IACKR = 0x0U; /* set INTC ISR vector table base addr to 0x0000000 as we don't use this field */
    
    HWINTC_CPR = 0x0; /* current priority level set to 0x0 */
    
}

