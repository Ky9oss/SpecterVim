#!/bin/bash
#
# Compile everything
# $1: builder
# $2: target_file(with absolute path) | custom command
# $3: width | nil
# $4: output_path | makefile_path | nil
#
# By Ky9oss

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

width=0
status=0
output_dir=./

if [[ -z $1 ]]; then
  printf "Error: builder must be defined."
  exit 1
fi

if [[ -n $2 && "custom" != "$1" ]]; then
  tmp="${2##*/}"
  output_name="${tmp%.*}"
elif [[ -n $2 && "custom" = "$1" ]]; then
  custom_command="$2"
else
  printf "Error: target file must be defined."
  exit 1
fi

if [[ -z $4 ]]; then
  output_path="$output_dir/$output_name"
else
  output_path="$4"
fi

case $1 in
fasm | asm)
  result=$(fasm "$2" "$output_path" 2>&1)
  status=$?
  ;;
gcc)
  CC="gcc-15"
  CC_FLAGS="-Wall -O0 -g3"
  result=$($CC $CC_FLAGS -o "$output_path" "$2" 2>&1)
  status=$?
  ;;
clang)
  ;;
make)
  # result=$(make -s "$output_name" -f makefilepath 2>&1)
  result=$(make -s "$output_name" 2>&1)
  status=$?
  ;;
autotools)
  ;;
cmake)
  result=$({
    mkdir -p build && cd build || exit
    cmake ..
    make
  })
  status=$?
  ;;
custom)
  result=$($custom_command)
  status=$?
  ;;
*)
  printf "Error: %s\n" "Parameters error" >&2
  exit 1
  ;;
esac

if [[ -n $3 ]]; then
  width=$3
fi

echo "$result" | source "$CURRENT_DIR/output.sh" $width $status
