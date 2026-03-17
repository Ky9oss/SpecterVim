#!/bin/bash
#
# Get all dependecies by gcc preprocessor(-M)
#
# By Ky9oss

find . -name '*.c' | while read src; do
    gcc -M -I/usr/include -I/usr/local/include -I./include "$src" 2>/dev/null
done | \
sed -e 's/[\\ ]/\n/g' \
    -e '/^$/d' \
    -e 's/^.*\.o://g'| sort -u > all-includes.txt

ctags --kinds-C=+px \
      --fields=+iaS \
      --extras=+q \
      -L all-includes.txt \
      --totals=yes
