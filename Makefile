################################################################################
# wxthings Makefile
# This script uses the multi-architecture build concept borrowed from the 
# website http://make.paulandlesley.org/multi-arch.html.
#
# Author: David Russak
#
# Version: $Id$
#
################################################################################

# This make script is first called from the main source directory and then one 
# directory level down in the build directory. The variable SRCDIR, defined in 
# target.mk and is passed in to the second invocation of this makefile and is 
# used to detect the current directory level. 
ifdef SRCDIR
  SOLUTION_DIR := ../..
else
  SOLUTION_DIR := ..
endif

SHARED_DIR := $(SOLUTION_DIR)/../Shared
MAKE_DIR := $(SHARED_DIR)/make
ifeq ($(SDL_EXTERN),)
  SDL_EXTERN := $(SOLUTION_DIR)/../sdlExtern
endif

include $(MAKE_DIR)/exports.mk

# OUTPUT_DIR is used in this file and in target.mk
OUTPUT_DIR := $(strip $(SOLUTION_DIR)/$(LIB_DIR))

# If the current directory does not have an underscore then include target.mk.
ifeq (,$(filter _%,$(notdir $(CURDIR))))

  include $(MAKE_DIR)/target.mk

else

  include $(OUTPUT_DIR)/locals.mk

  # This is the portion of the script which will be run in the build 
  # directory. It uses VPATH to find the source files.

  .SUFFIXES:

  # in filebrws.cpp we need to resize comboboxes in toolbar
  ifndef GTK_CFLAGS
  ifeq (gtk2, $(findstring gtk2, $(WX_VER)))
  GTK_CFLAGS = $(shell pkg-config --cflags gtk+-2.0)
  else
  GTK_CFLAGS = $(shell gtk-config --cflags)
  endif
  endif

  INC := -I$(SDL_EXTERN)/include $(WX_INCLUDES) -I$(OUTPUT_DIR)
  LIB := $(OUTPUT_DIR)/libwx_gtk2$(BLD_LTR)_wxthings-2.8.a
  USER_SPECIALS := $(INC) $(GTK_CFLAGS)
  CPPFLAGS += $(GTK_CFLAGS)

  VPATH := $(SRCDIR)/src
  CPP_SRC := block.cpp bmpcombo.cpp dropdown.cpp filebrws.cpp \
             genergdi.cpp geometry.cpp menubtn.cpp optvalue.cpp \
             range.cpp spinctld.cpp toggle.cpp

  include $(MAKE_DIR)/obj_dep.mk

  # Create the library
  $(LIB): $(CPP_OBJS)
	  @echo Creating library $(LIB).
	  $(AR) $(LIB) $(CPP_OBJS)

  include $(MAKE_DIR)/rules.mk

endif