# -*- Mode: makefile-gmake; indent-tabs-mode: t; tab-width: 2 -*-
#
# build.mk --- Build an STM32F4 test program.
#
# Copyright (C) 2012, Galois, Inc.
# All Rights Reserved.
#
# This software is released under the "BSD3" license.  Read the file
# "LICENSE" for more information.
#
# Written by James Bielman <jamesjb@galois.com>, December 07, 2012
#

USLEEP_TEST_IMG       := usleep_test
USLEEP_TEST_OBJECTS   := main.o

USLEEP_TEST_CFLAGS    += $(FREERTOS_CFLAGS)
USLEEP_TEST_CFLAGS    += -I$(TOP)/include
USLEEP_TEST_CFLAGS    += -I$(TOP)/hwf4/include
USLEEP_TEST_LIBRARIES := libhwf4.a libstm32_usb.a libFreeRTOS.a

ifeq "$(CONFIG_BOARD)" "px4"
$(eval $(call image,USLEEP_TEST))
endif
