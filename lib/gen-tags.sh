#!/bin/bash
#
# Get all dependecies by gcc preprocessor(-M)
#
# $@: languages
#
# By Ky9oss

C_CTAGS="./tagfiles/c/tags"
MAKE_CTAGS="./tagfiles/make/tags"

mkdir -p ./tagfiles/c/
mkdir -p ./tagfiles/make/

for lang in "$@"; do
  lang=$(echo "$lang" | tr '[:upper:]' '[:lower:]')
  case $lang in
  c)
    # Use $PWD instead of . in POSIX tools will return absolute-path results.
    find "$PWD" -name '*.c' | while read src; do
      gcc -M -I/usr/include -I/usr/local/include -I"$PWD/include" "$src" 2>/dev/null
    done |
      sed -e 's/[\\ ]/\n/g' \
        -e '/^$/d' \
        -e 's/^.*\.o://g' | sort -u >all-includes.txt

    if [[ -e $C_CTAGS ]]; then
      rm $C_CTAGS
    fi
    touch $C_CTAGS

    ctags --kinds-C=+px \
      --fields=+iaS \
      --extras=+q \
      -L all-includes.txt \
      --totals=yes \
      --tag-relative=no \
      -f $C_CTAGS && printf "Done: %s\n" "$C_CTAGS has generated."
    ;;
  make)
    if [[ -e $MAKE_CTAGS ]]; then
      rm $MAKE_CTAGS
    fi
    touch $MAKE_CTAGS

    ctags --languages=Make \
      --tag-relative=no \
       $PWD/Makefile $PWD/*.make && mv $PWD/tags $MAKE_CTAGS && printf "Done: %s\n" "$MAKE_CTAGS has generated."
    ;;
  *)
    printf "Error: %s\n" "Parameters error" >&2
    exit 1
    ;;
  esac
done
