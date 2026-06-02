#!/bin/bash
#
# Layout the result from compilation
#
# pipe input: result
# $1: width
# $2: status
#
# By Ky9oss

read -d "" result

width=0

if [[ -n $1 ]]; then
  width=$1
fi

if [[ $2 -eq 0 ]]; then
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

