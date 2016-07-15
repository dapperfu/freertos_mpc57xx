#==================================================================================================
#
#   (c) Copyright 2015 Freescale Semiconductor Inc.
#   
#   This program is free software; you can redistribute it and/or modify it under
#   the terms of the GNU General Public License (version 2) as published by the
#   Free Software Foundation >>>> AND MODIFIED BY <<<< the FreeRTOS exception.
#
#   ***************************************************************************
#   >>!   NOTE: The modification to the GPL is included to allow you to     !<<
#   >>!   distribute a combined work that includes FreeRTOS without being   !<<
#   >>!   obliged to provide the source code for proprietary components     !<<
#   >>!   outside of the FreeRTOS kernel.                                   !<<
#   ***************************************************************************
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#   
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
#==================================================================================================


COMPILER_ROOTDIR    = c:/tools/S32_Power_v1.0/Cross_Tools/powerpc-eabivle-4_9/bin/

SYSROOT = c:/tools/S32_Power_v1.0/S32DS/e200_ewl2
#LIBDIR = c:/tools/S32_Power_v1.0/Cross_Tools/powerpc-eabivle-4_9/powerpc-eabivle/newlib


AS		= $(COMPILER_ROOTDIR)powerpc-eabivle-as
CC		= $(COMPILER_ROOTDIR)powerpc-eabivle-gcc
LD 		= $(COMPILER_ROOTDIR)powerpc-eabivle-gcc

TARGET     = demo_flash

ASFLAGS  = -gdwarf-2 -L -mregnames -mvle

CFLAGS   =  --sysroot=$(SYSROOT) -I../../Source/include -I../../Source/portable/GCC/PowerPC_Z4 -Isrc -Isrc_hw \
			-mcpu=e200z4 -mfpu=sp_full -mvle -mfloat-gprs=yes -mhard-float -static \
			-O3 -g3 -fno-strict-aliasing -Wall -Wextra -Werror -Wdouble-promotion -Wfloat-equal \
			-Wconversion -Wpointer-arith -std=gnu99 -ffunction-sections -fdata-sections

			
LDFLAGS =  --sysroot=$(SYSROOT) -mcpu=e200z4 -mfpu=sp_full -Xlinker -Map=bin/$(TARGET).map \
			-nostartfiles -Tld/$(TARGET).ld -static -Xlinker --gc-sections -Xlinker --print-gc-sections
			
			
# Linking
OBJFILES =  bin/crt0.o \
            bin/cbootstrap.o \
            bin/main.o \
            bin/handlers.o \
            bin/hw_flashrchw.o \
            bin/hw_platform.o \
            ../../Source/tasks.o \
            ../../Source/queue.o \
            ../../Source/list.o \
            ../../Source/croutine.o \
            ../../Source/portable/MemMang/heap_1.o \
            ../../Source/portable/GCC/PowerPC_Z4/port.o \
            ../../Source/portable/GCC/PowerPC_Z4/portasm.o


# Linking
bin/$(TARGET).elf: $(OBJFILES)
	$(LD) $(LDFLAGS) -Xlinker -o -Xlinker $@ $(OBJFILES)

# Compiling
bin/%.o: src/%.c
	$(CC) $(CFLAGS) -c -o $@ $<

bin/%.o: src_hw/%.c
	$(CC) $(CFLAGS) -c -o $@ $<
    
bin/%.o: ../../Source/%.c
	$(CC) $(CFLAGS) -c -o $@ $<

bin/%.o: ../../Source/portable/MemMang/%.c
	$(CC) $(CFLAGS) -c -o $@ $<

bin/%.o: ../../Source/portable/GCC/PowerPC_Z4/%.c
	$(CC) $(CFLAGS) -c -o $@ $<


# Assembling
bin/%.o: src/%.s
	$(AS) $(ASFLAGS) -o $@ $<

bin/%.o: src_hw/%.s
	$(AS) $(ASFLAGS) -o $@ $<


# default goal
all: bin/$(TARGET).elf

.PHONY: cleanobj
cleanobj:
	rm -v -f $(OBJFILES)

.PHONY: clean
clean:
	rm -v -f bin/*
	rm -v -f $(OBJFILES)

build: clean all
