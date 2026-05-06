#!/bin/bash
#
# Compile by Makefile for Quickfix
# $1: dir (droped)
# $1: width
# $2: make target
#
# By Ky9oss

# if [[ -z $1 ]]; then
#   printf "%s\n" "ERROR: The directory where Makefile is located must be provided."
#   exit 1
# fi

is_makefile=$(ls | grep "Makefile")

if [[ $? -ne 0 ]]; then
  printf "%s\n" "ERROR: Makefile is not found."
  exit 1
fi

width=0
# width=$(tput cols)

if [[ -n $1 ]]; then
  width=$1
fi

# cd "$1" || exit 1
result=$(make -s "$2" 2>&1)

if [[ $? -eq 0 ]]; then
  # printf "%s\n" "--------[COMPILATION SUCCESS]--------"
  text="--------[COMPILATION SUCCESS]--------"
else
  # printf "%s\n" "--------[COMPILATION FAILED]--------"
  text="--------[COMPILATION FAILED]--------"
fi

len=${#text}
pad=$((((width - len) / 2) - 5))

if [[ $pad -gt 0 ]]; then
  printf "%*s%s\n" "$pad" "" "$text"
else
  printf "%s\n" "$text"
fi

printf "%s" "$result"

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
