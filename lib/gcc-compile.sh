#!/bin/bash
#
# Compile by gcc-15 and format output
# $1: filename
#
# By Ky9oss

output_name=${1%.*}
result="$(gcc-15 -Wall -O2 -o $output_name $1 2>&1)"
if [[ $? -eq 1 ]]; then
  printf "%s\n" "--------[COMPILATION FAILED]--------"
  printf "%s" "$result"
else 
  printf "%s\n" "--------[COMPILATION SUCCESS]--------"
  printf "%s" "$result";
fi
