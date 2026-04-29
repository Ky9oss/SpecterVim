#!/bin/bash
#
# Compile for Makefile
# $1: dir
#
# By Ky9oss

if [[ -z $1 ]]; then
  printf "%s\n" "ERROR: The directory where Makefile is located must be provided."
  exit 1
fi

result=$(cd "$1" && make -s 2>&1)
if [[ $? -eq 1 ]]; then
  printf "%s\n" "--------[COMPILATION FAILED]--------"
  printf "%s" "$result"
else
  printf "%s\n" "--------[COMPILATION SUCCESS]--------"
  printf "%s" "$result"
fi

#######################################################################################################
# Use this script, you must set absolute path instead of relative path for compilation.
#
# EXAMPLE MAKEFILE:
#
# SPL_INCLUDE_DIR = $(realpath ../include)
# SPL_LIB_DIR     = $(realpath ../lib)
# SPL_BIN_DIR     = $(realpath ../bin)
# CURRENT_DIR     = $(realpath .)
#
# SPL_LIB         = $(SPL_LIB_DIR)/libspl.a
# SPL_HDRS        = \
# common_hdrs.h\
# dir_utils.h\
# error_exits.h\
# escapes.h\
# get_nums.h\
# hash.h\
# ps_utils.h\
# show_time.h\
# sys_hdrs.h\
# time_utils.h
#
# SRCS       = $(wildcard *.c)
# ELFS       = $(patsubst %.c,%,$(SRCS))
# CC         = gcc-15
# CFLAGS    += -Wall -g
#
# ASMS       = $(patsubst %.c,%.s,$(SRCS))
# ASMFLAGS   = -S -masm=intel -fno-asynchronous-unwind-tables -fno-exceptions
#
# all: $(ELFS) 
#
# asm: $(ASMS)
#
# %.s:$(CURRENT_DIR)/%.c
# 	$(CC) $(CFLAGS) $(ASMFLAGS) -I$(SPL_INCLUDE_DIR) -L$(SPL_LIB_DIR) $< -lspl -o $(SPL_BIN_DIR)/$@
#
# %:$(CURRENT_DIR)/%.c
# 	$(CC) $(CFLAGS) -I$(SPL_INCLUDE_DIR) -L$(SPL_LIB_DIR) $< -lspl -o $(SPL_BIN_DIR)/$@
#
# clean:
# 	-rm -f $(SPL_BIN_DIR)/$(ELFS)
#
# .PHONY: all clean asm
#######################################################################################################

