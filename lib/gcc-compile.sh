#!/bin/bash
#
# Compile by gcc-15 and format output
# $1: filename
# $2: output_path | nil
#
# By Ky9oss

if [[ -z $1 ]]; then
  printf "%s\n" "ERROR: The file's name you need to compile must be provided."
  exit 1
fi

if [[ -n $2 ]]; then
  output_dir=${2%/*}
  mkdir -p "$output_dir"

  output_path="$2"

  # last_char=${2:-1:1}
  # if [[ "/" = "$last_char" ]]; then
  #   output_dir=$2
  # else
  #   output_dir=$2/
  # fi
  #
  # output_name=${1%.*}
  # output_path=$output_dir$output_name
else
  output_name=${1%.*}
  output_path=./$output_name
fi

result=$(gcc-15 -Wall -O2 -o "$output_path" "$1" 2>&1)
if [[ $? -eq 1 ]]; then
  printf "%s\n" "--------[COMPILATION FAILED]--------"
  printf "%s" "$result"
else
  printf "%s\n" "--------[COMPILATION SUCCESS]--------"
  printf "%s" "$result"
fi
