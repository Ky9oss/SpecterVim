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
