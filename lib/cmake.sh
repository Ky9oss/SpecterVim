#!/bin/bash
#
# Build by Cmake

mkdir -p build && cd build || exit
cmake ..
make
