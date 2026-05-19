#!/bin/bash
#
# Compile asm by fasm
# $1: width
# $2: target_file(with absolute path)
# $3: output_dir | nil
# $4: output_name(without path) | nil
#
# By Ky9oss

width=0
output_dir=./

if [[ -n $1 ]]; then
  width=$1
fi

if [[ -n $2 ]]; then
  tmp="${2##*/}"
  output_name="${tmp%.*}"
else
  printf "Error: target file must be defined."
  exit 1
fi

if [[ -n $3 ]]; then
  output_dir=$3
  mkdir -p "$output_dir"
fi

if [[ -n $4 ]]; then
  output_name=$4
fi

result=$(fasm "$2" "$output_dir/$output_name" 2>&1)

if [[ $? -eq 0 ]]; then
  text="--------[COMPILATION SUCCESS]--------"
else
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
