#!/bin/bash
#
# Get all dependecies by gcc preprocessor(-M)
#
# By Ky9oss

find . -name '*.c' | while read -r src; do
    gcc -M -I/usr/include -I/usr/local/include "$src" 2>/dev/null
done | \
sed -e 's/[\\ ]/\n/g' \
    -e '/^$/d' \
    -e '/\.o:.*$/d' \
    -e '/\.c$/d' | sort -u > all-includes.txt

ctags --kinds-C=+px \
      --fields=+iaS \
      --extras=+q \
      -L all-includes.txt \
      --totals=yes
