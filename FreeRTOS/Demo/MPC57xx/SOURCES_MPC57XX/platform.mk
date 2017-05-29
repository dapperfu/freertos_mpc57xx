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
OBJFILES_PLATFORM  :=  $(OUT_ROOT)/obj/$(TEST_NAME)/hw_flashrchw.o \
                       $(OUT_ROOT)/obj/$(TEST_NAME)/hw_platform.o 

$(OUT_ROOT)/obj/$(TEST_NAME)/%.o: ../SOURCES_MPC57XX/%.c
	$(CC) $(CFLAGS) -c -o $(shell $(CYGPATH) -m -i $@) $<					   
					   
$(OUT_ROOT)/obj/$(TEST_NAME)/%.o: ../SOURCES_MPC57XX/%.s
	$(AS) $(ASFLAGS) -o $(shell $(CYGPATH) -m -i $@) $<