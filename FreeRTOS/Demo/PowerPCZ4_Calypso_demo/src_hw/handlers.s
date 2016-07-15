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


  .section ".vectors","ax"

  .extern __external_interrupt_handler
  .extern vPortYield
  
 
  .align 4 
CI_ESR:
  e_li r0, 0x0
  e_b __generic_exception_handler

  .align 4   
MC_ESR:
  e_li r0, 0x1
  e_b __generic_exception_handler

  .align 4   
DS_ESR:
  e_li r0, 0x2
  e_b __generic_exception_handler

  .align 4   
IS_ESR:
  e_li r0, 0x3
  e_b __generic_exception_handler
  
  .align 4   
EI_ESR:
  e_b __external_interrupt_handler

  .align 4 
Align_ESR:
  e_li r0, 0x5
  e_b __generic_exception_handler

  .align 4   
Program_ESR:
  e_li r0, 0x6
  e_b __generic_exception_handler

  .align 4   
FP_Unav_ESR:
  e_li r0, 0x7
  e_b __generic_exception_handler
  
  .align 4   
SC_ESR:
  e_b vPortYield 

  .align 4   
AP_Unav_ESR:
  e_li r0, 0x9
  e_b __generic_exception_handler
  
  .align 4   
DEC_ESR:
  e_li r0, 0xA
  e_b __generic_exception_handler

  .align 4   
FIT_ESR:
  e_li r0, 0xB
  e_b __generic_exception_handler

  .align 4   
WDT_ESR:
  e_li r0, 0xC
  e_b __generic_exception_handler

  .align 4   
DTLB_error_ESR:
  e_li r0, 0xD
  e_b __generic_exception_handler

  .align 4   
ITLB_error_ESR:
  e_li r0, 0xE
  e_b __generic_exception_handler

  .align 4   
Debug_ESR:
  e_li r0, 0xF
  e_b __generic_exception_handler
   
  .align 4
__generic_exception_handler:
  # do not return from this handler
  # if needed add specific code here
  e_b __generic_exception_handler   
 

  .end
