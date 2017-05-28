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

# S32_Power_v1.1 installed to C:\NXP
# By putting it in 'unix' format we can skip
# COMPILER_ROOTDIR := 
# COMPILER_LIBS := 
# PATH to FreeRTOS code we are testing
# OS_ROOT := /cygdrive/c/Freescale/freertos-mpc57xx/FreeRTOS


ifeq ($(detected_OS),Windows)
	# S32_Power_v1.1 installed to C:\NXP
	# By putting it in 'unix' format we can skip
	COMPILER_ROOTDIR := /cygdrive/c/NXP/S32_Power_v1.1/Cross_Tools/powerpc-eabivle-4_9/bin
	COMPILER_LIBS := /cygdrive/c/NXP/S32_Power_v1.1/S32DS/e200_ewl2
	# PATH to FreeRTOS code we are testing
	OS_ROOT := /cygdrive/c/NXP/freertos-mpc57xx/FreeRTOS
endif

ifeq ($(detected_OS),Linux)
	# S32_Power_v1.1 installed to /opt/NXP
	COMPILER_ROOTDIR = /opt/NXP/S32_Power_v1.1/Cross_Tools/powerpc-eabivle-4_9/bin/
	COMPILER_LIBS = /opt/NXP/S32_Power_v1.1/S32DS/e200_ewl2
	# PATH to FreeRTOS code we are testing
	OS_ROOT = /opt/NXP/freertos-mpc57xx/FreeRTOS
endif

