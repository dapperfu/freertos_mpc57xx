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

TEST_NAME := GEN_001

#force dynamic test

include ../SOURCES_MPC57XX/platform.mk
include ../SOURCES_BOOT/boot.mk
include ../compiler_options.mk
include ../appl_common.mk
include ../freeRTOS.mk


# test generic files
OBJFILES := $(OBJFILES_OS) $(OBJFILES_PLATFORM) $(OBJFILES_BOOT) $(OBJFILES_APPL) $(OBJFILES_HEAP)
			
# test specific files
OBJFILES +=  $(OUT_ROOT)/obj/$(TEST_NAME)/main.o \
			 $(OUT_ROOT)/obj/$(TEST_NAME)/main_full.o \
			 $(OUT_ROOT)/obj/$(TEST_NAME)/reg_test.o

# default goal
all: $(OUT_ROOT)/$(TEST_NAME).elf

# Compiling
$(OUT_ROOT)/obj/$(TEST_NAME)/%.o: ./%.c
	$(CC) $(CFLAGS) -c -o $@ $<

# Assembling
$(OUT_ROOT)/obj/$(TEST_NAME)/%.o: ./%.s
	$(AS) $(ASFLAGS) -o $@ $<
	
# Linking
$(OUT_ROOT)/$(TEST_NAME).elf: $(OBJFILES) 
	$(LD) $(LDFLAGS) -Xlinker -o -Xlinker $@ $(OBJFILES)

