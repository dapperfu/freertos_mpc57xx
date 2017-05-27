#==================================================================================================
#
#  (c) Copyright 2015 Freescale Semiconductor Inc.
#  
#  This program is free software; you can redistribute it and/or modify it under
#  the terms of the GNU General Public License (version 2) as published by the
#  Free Software Foundation >>>> AND MODIFIED BY <<<< the FreeRTOS exception.
#
#  ***************************************************************************
#  >>!   NOTE: The modification to the GPL is included to allow you to     !<<
#  >>!   distribute a combined work that includes FreeRTOS without being   !<<
#  >>!   obliged to provide the source code for proprietary components     !<<
#  >>!   outside of the FreeRTOS kernel.                                   !<<
#  ***************************************************************************
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
#================================================================================================*/
ASFLAGS  := -g --gdwarf-sections --gstabs+ -L -mregnames -mvle -I$(CRT_DIR)/SOURCES_MPC57XX -I$(CRT_DIR)/src_test_cases/$(TEST_NAME)

CFLAGS   :=  --sysroot=$(COMPILER_LIBS) \
            -I$(OS_ROOT)/Source/include \
			-I$(OS_ROOT)/Source/portable/GCC/PowerPC_Z4 \
			-I$(CRT_DIR)/SOURCES \
			-I$(CRT_DIR)/SOURCES_MPC57XX \
			-mcpu=e200z4 -mfpu=sp_full -mvle -mfloat-gprs=yes -mhard-float -static \
			-O3 -g3 -fno-strict-aliasing -Wall -Wextra -Werror -Wdouble-promotion -Wfloat-equal \
			-Wconversion -Wpointer-arith -std=gnu99 -ffunction-sections -fdata-sections

CFLAGS += -DTEST_DYNAMIC=1 -DconfigSUPPORT_STATIC_ALLOCATION=0 -DconfigSUPPORT_DYNAMIC_ALLOCATION=1

ifneq (,$(findstring mpc5746c,$(PLATFORM)))
    CFLAGS += -DMPC5746C=1
else
    CFLAGS += -DMPC5748G=1
endif


LDFLAGS :=  --sysroot=$(COMPILER_LIBS) -mcpu=e200z4 -mfpu=sp_full -Xlinker -Map=$(OUT_ROOT)/$(TEST_NAME).map \
			-nostartfiles -T$(CRT_DIR)/LINKERSCRIPTS/flash_$(PLATFORM).ld -static -Xlinker --gc-sections -Xlinker --print-gc-sections
