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
CYGPATH := 
MAKE	:= make
MKDIR	:= mkdir
RM	:= rm
ECHO	:= echo

include user_paths.mk

CRT_DIR := $(shell pwd)

ifndef OUT_DIR
	OUT_DIR := $(CRT_DIR)
else
	OUT_DIR := $(OUT_DIR)
endif
OUT_ROOT:=$(OUT_DIR)/OUT



AS		:= $(COMPILER_ROOTDIR)powerpc-eabivle-as
CC		:= $(COMPILER_ROOTDIR)powerpc-eabivle-gcc
LD 		:= $(COMPILER_ROOTDIR)powerpc-eabivle-gcc


ifndef PLATFORM
	PLATFORM := mpc5746c
endif

export COMPILER_ROOTDIR
export COMPILER_LIBS
export OS_ROOT

export AS
export CC
export LD
export PLATFORM
export OUT_ROOT
export CRT_DIR
export CYGPATH

all: OUT_DIR_CREATE GEN_001

OUT_DIR_CREATE:
	$(ECHO) using platform: $(PLATFORM)
	$(RM) -fr $(OUT_ROOT)
	$(MKDIR) -p $(OUT_ROOT)
	$(MKDIR) $(OUT_ROOT)/obj

GEN_001: OUT_DIR_CREATE
	$(MKDIR) -p $(OUT_ROOT)/obj/GEN_001
	$(MAKE) -C SOURCES
