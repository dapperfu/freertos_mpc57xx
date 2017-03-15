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
SRAM_SIZE = DEFINED(SRAM_SIZE) ? SRAM_SIZE : 0x80000;
SRAM_BASE_ADDR = DEFINED(SRAM_BASE_ADDR) ? SRAM_BASE_ADDR : 0x40000000;
/* Define Memories in the system */
MEMORY
{
   APP_INTERNAL_FLASH(arx) : ORIGIN = 0x00FC0000, LENGTH = 0x00010000 /* 64K */
   INTERNAL_RAM(rw)    : ORIGIN = 0x40000000, LENGTH = 0x00080000 /* 512K */
}

SECTIONS
{
    .rchwdata :
    {
        /* User needs +R permissions from __user_flash_start__ to __user_flash_end__ */
        __user_flash_start__ = .;
        KEEP(*(.rchwdata .rchwdata.* .rchw .rchw.*))
    } > APP_INTERNAL_FLASH
    
    .bootDescriptor (NOLOAD) :
    {
       KEEP(*(.bootDescriptor))
    } > APP_INTERNAL_FLASH

    .appDescriptor :
    {
        KEEP(*(.appDescriptor))
    } > APP_DESC

    /* PPC ABI defines .sbss2 and .sdata2 as read-only sections.  Therefore we place them in flash only. */
    /* See additional notes regarding _SDA_BASE_ below */
    .sbss2 :
    {
        /* PPC EABI requires that all bytes witin .sbss2 and sdata2 be located within a signed 16-bit offset of _SDA2_BASE_ */
        _SDA2_BASE_ = .;

        __sbss2_start = .;
        *(SORT_BY_ALIGNMENT(.sbss2) SORT_BY_ALIGNMENT(.sbss2.*))
        __sbss2_end = .;
    } > APP_INTERNAL_FLASH

    /* small const variables */
    .sdata2 :
    {
        __sdata2_start = .;
        *(SORT_BY_ALIGNMENT(.sdata2) SORT_BY_ALIGNMENT(.sdata2.*) SORT_BY_ALIGNMENT(.gnu.linkonce.s2.*))
        __sdata2_end = .;

        _SDA2_END_ = .;

        ASSERT(( (_SDA2_END_ - _SDA2_BASE_) < (32*1024) ), "Error: SDA2 sections out of range");
    } > APP_INTERNAL_FLASH

     /* User needs +RX permissions from __user_functions_start__ to  __user_functions_end__ Overlaps with user flash region - MPU must OR permissions. */
    .text ALIGN(0x20):
    {
        __user_functions_start__ = .;
        *(.text.startup)
        *(.startup)
        *(.text)
        *(.init)
        *(.text.*)
        *(.gnu.linkonce.t.*)
        __user_functions_end__ = ALIGN(0x20);
    } > APP_INTERNAL_FLASH

    .ctors :
    {
        __CTOR_LIST__ = .;
        /* The init_cpp, static constructor code calls these from last to
           first. init_priority specified functions are therefor called first.
           Contrary to what might be expected, objects with lower specified
           init_priority actually are assigned to .ctor.<nnnn> sections with
           higher numbers i.e. .ctor.<65536-init_priority>
           The behavior is as specified then - objects with lower init_priority
           numbers get constructed before those with higher init_priority
           numbers */
        /* Simple, static constructors with NO init_priority specified */
        KEEP (*(EXCLUDE_FILE (*crtbegin.o *crtbegin?.o *crtend.o *crtend?.o ) .ctors))
        /* Static constructors with init_priority specified */
        KEEP (*(SORT_BY_NAME(.ctors.*)))
        __CTOR_END__ = .;

        /* TODO FIXME Allow the current set of constructors until we can remove them.
           Adding new ctors will cause this assert to fail the build. This will be set
           to 0 once current ctors are removed. */
        ASSERT( SIZEOF(.ctors) == 0x0, "Runtime constructors disallowed." );

    } > APP_INTERNAL_FLASH

    .dtors :
    {
        __DTOR_LIST__ = .;
        /* The entire dtors section can be eliminated in our
           embedded world since we never exit main(). */
        /* KEEP (*crtbegin.o(.dtors))                 */
        /* KEEP (*(EXCLUDE_FILE (*crtend.o ) .dtors)) */
        /* KEEP (*(SORT_BY_NAME(.dtors.*)))           */
        /* KEEP (*(.dtors))                           */
        __DTOR_END__ = .;

        ASSERT( SIZEOF(.dtors) == 0, "Runtime destructors disallowed." );
    } > APP_INTERNAL_FLASH

    .rodata :
    {
        __rodata_start = .;
        *(SORT_BY_ALIGNMENT(.rodata) SORT_BY_ALIGNMENT(.rodata.*) SORT_BY_ALIGNMENT(.gnu.linkonce.r.*))
        __rodata_end = .;
        __user_flash_end__ = ALIGN(0x20);
    } > APP_INTERNAL_FLASH

    .core_exceptions_table ALIGN(0x1000) :
    {
        __IVPR_ADDR = .;
        __vectors_start = .;
        KEEP(*(.core_exceptions_table .core_exceptions_table.*))
        __vectors_end = .;
    } > APP_INTERNAL_FLASH


__data_flash_start__ = .;
    .data :
    {
        /* User needs +RW permissions to all sections from __user_data_start__ to __user_data_end__ */
        __user_data_start__ = .;
        __data_start__ = .;
        *(SORT_BY_ALIGNMENT(.data) SORT_BY_ALIGNMENT(.data.*) SORT_BY_ALIGNMENT(.gnu.linkonce.d.*) SORT_BY_ALIGNMENT(.codeSpaceInRam))
        __data_end__ = .;
    }  > INTERNAL_RAM AT > APP_INTERNAL_FLASH

    /* TODO FIXME PPC EABI requires that all bytes witin .sbss and sdata be located within a signed 16-bit offset of _SDA_BASE_.
       How do we enforce this? Should _SDA_BASE_ be defined in between the start of .sdata and end of .sbss?
       For now, we define _SDA_BASE_ at the start of .sdata and expect both regions to fit in the positive offset range. 
       This may be moot, as the compiler doesn't seem to use r2 or r13 to access data from these sections. */
    /* small initialized data */
    .sdata :
    {
        _SDA_BASE_ = .;

        __sdata_start__ = .;
        *(SORT_BY_ALIGNMENT(.sdata) SORT_BY_ALIGNMENT(.sdata.*) SORT_BY_ALIGNMENT(.gnu.linkonce.s.*))
        __sdata_end__ = .;
    } > INTERNAL_RAM AT>APP_INTERNAL_FLASH

    /* small un-initialized variables */
    .sbss (NOLOAD) :
    {
        __sbss_start__ = .;
        *(SORT_BY_ALIGNMENT(.sbss) SORT_BY_ALIGNMENT(.sbss.*) SORT_BY_ALIGNMENT(.gnu.linkonce.sb.*) SORT_BY_ALIGNMENT(.scommon))
        __sbss_end__ = .;

        _SDA_END_ = .;

        ASSERT(( (_SDA_END_ - _SDA_BASE_) < (32*1024) ), "Error: SDA sections out of range");
    } > INTERNAL_RAM

    .bss (NOLOAD) :
    {
       __bss_start__ = .;
       *(SORT_BY_ALIGNMENT(.bss) SORT_BY_ALIGNMENT(.bss.*) SORT_BY_ALIGNMENT(.gnu.linkonce.b.*) SORT_BY_ALIGNMENT(COMMON))
       __bss_end__ = .;
       __user_data_end__ = ALIGN(0x20);
    } > INTERNAL_RAM

    /* Generate Stack Section */
    .stack ALIGN(0x20) (NOLOAD) :
    {
       _stack_end = .;
       __STACK_END__ = .;
       . += _STACK_SIZE;
       . = ALIGN(0x20);
       __SP_INIT__ = .;
       __stack = .;

       ASSERT(( (__stack - _stack_end) % 0x20 == 0), "__stack must be 32 byte aligned" );
    } > INTERNAL_RAM

	
    /* Zero initialized, cache-inhibited (if needed) section for use by DMA buffers, etc. */
    /* Must be last section of SRAM */
    .dma_data ALIGN(0x20) (NOLOAD) :
    {
        /* User and DMA bus master needs +RW permissions from __dma_data_start__ to  __dma_data_end__ */
        __dma_data_start__ = .;
        *(SORT_BY_ALIGNMENT(.uncached) SORT_BY_ALIGNMENT(.uncached.*))
        __dma_data_end__ = ALIGN(0x20);
    } > INTERNAL_RAM

/*-------- LABELS USED IN CODE -------------------------------*/

/* Labels for Copying Initialised Data from Flash to RAM */
__DATA_SRAM_ADDR  = ADDR(.data);
__SDATA_SRAM_ADDR = ADDR(.sdata);

__DATA_SIZE   = SIZEOF(.data);
__SDATA_SIZE  = SIZEOF(.sdata);

__DATA_ROM_ADDR  = LOADADDR(.data);
__SDATA_ROM_ADDR = LOADADDR(.sdata);

/* Labels Used for Initialising SRAM ECC */
__SRAM_SIZE      = SRAM_SIZE;
__SRAM_BASE_ADDR = SRAM_BASE_ADDR;

__user_data_size__ = __user_data_end__ - __user_data_start__;

__BSS_SIZE = __bss_end__ - __bss_start__;

/* CRC loc is dependent on end of ROM section. */
__CodeCRCAddr = __SDATA_ROM_ADDR + __SDATA_SIZE;
__boot = __start;
}
