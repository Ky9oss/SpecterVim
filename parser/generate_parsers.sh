#!/bin/bash
#
# Generate parsers

git clone https://github.com/RubixDev/tree-sitter-asm.git
cd tree-sitter-asm || exit
make && mv libtree-sitter-asm.so ../asm.so
cp -r queries ../../
