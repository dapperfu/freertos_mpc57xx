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

_STACK_SIZE = DEFINED(_STACK_SIZE) ? _STACK_SIZE : 0x400;


/* Define Memories in the system */
MEMORY
{
   INTERNAL_FLASH(arx) : ORIGIN = 0x00FC0000, LENGTH = 0x00008000 /* 32K */
   INTERNAL_RAM(rw)    : ORIGIN = 0x40000000, LENGTH = 0x0000C000 /* 48K */
}

ENTRY(__start)

SECTIONS
{

.rchwdata : {
   KEEP(*(.rchwdata))
} > INTERNAL_FLASH


.vectors ALIGN(0x100): {
   __IVPR_ADDR = .; /* vector table start */
   __vectors_start = .;
   KEEP(*(.vectors))
   __vectors_end = .;
} > INTERNAL_FLASH


.startup ALIGN(16): {
   KEEP(*(.startup))
} > INTERNAL_FLASH

.text : {
   *(.text)
   *(.text.*)
   *(.gnu.linkonce.t.*)
} > INTERNAL_FLASH

/* RO data */
.rodata : {
   __rodata_start = .;
   __INIT_DATA_START__ = .;
   *(.rodata)
   *(.rodata.*)
   *(.gnu.linkonce.r.*)
   __rodata_end = .;
} > INTERNAL_FLASH

/* small const variables */
.sdata2 : {
   __sdata2_start = .;
   *(.sdata2)
   *(.sdata2.*)
   *(.gnu.linkonce.s2.*)
   __sdata2_end = .;
} > INTERNAL_FLASH

__data_flash_start__ = .;

/* initialized variables */
.data : {
   __data_start__ = .;
   *(.data)
   *(.data.*)
   *(.gnu.linkonce.d.*)
   __data_end__ = .;
} > INTERNAL_RAM AT > INTERNAL_FLASH


/* small initialized variables */
.sdata : {
   __sdata_start__ = .;
   *(.sdata)
   *(.sdata.*)
   *(.gnu.linkonce.s.*)
   __sdata_end__ = .;
} > INTERNAL_RAM AT > INTERNAL_FLASH


/* small un-initialized variables */
.sbss : {
   __sbss_start__ = .;
   *(.sbss)
   *(.sbss.*)
   *(.gnu.linkonce.sb.*)
   *(.scommon)
   __sbss_end__ = .;
} > INTERNAL_RAM

/* small un-initialized variables */
.bss : {
   __bss_start__ = .;
   *(.bss)
   *(.bss.*)
   *(.gnu.linkonce.b.*)
   *(COMMON)
   . = ALIGN(4);
   __bss_end__ = .;
} > INTERNAL_RAM


/* Generate Stack Section */
.stack : {
   _stack_end = .;
   __STACK_END__ = .;
   . += _STACK_SIZE;
   . = ALIGN(16);
   __SP_INIT__ = .;
   __stack = .;
} > INTERNAL_RAM


}

