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
# compiler path
COMPILER_ROOTDIR = /opt/Freescale/S32_Power_v1.1/Cross_Tools/powerpc-eabivle-4_9/bin/
COMPILER_LIBS = /opt/Freescale/S32_Power_v1.1/S32DS/e200_ewl2

# PATH to FreeRTOS code we are testing
# OS_ROOT := C:/w/FR9.0.0/FreeRTOSv9.0.0/FreeRTOS
OS_ROOT = /opt/Freescale/freertos/FreeRTOS
#PATH to LATUTERBACH T32
LATUTERBACH_PATH := c:/tools/T32


# convert paths to unix
COMPILER_ROOTDIR := $(COMPILER_ROOTDIR)
COMPILER_LIBS := $(COMPILER_LIBS)
OS_ROOT := $(OS_ROOT)
LATUTERBACH_PATH := $(LATUTERBACH_PATH)
