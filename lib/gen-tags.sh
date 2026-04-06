#!/bin/bash
#
# Get all dependecies by gcc preprocessor(-M)
#
# $@: languages
#
# By Ky9oss

C_CTAGS="./tagfiles/c/tags"
LUA_CTAGS="./tagfiles/lua/tags"
MAKE_CTAGS="./tagfiles/make/tags"
SH_CTAGS="./tagfiles/sh/tags"
AUTOMAKE_CTAGS="./tagfiles/automake/tags"
AUTOCONF_CTAGS="./tagfiles/autoconf/tags"

for lang in "$@"; do
  lang=$(echo "$lang" | tr '[:upper:]' '[:lower:]')
  mkdir -p ./tagfiles/"$lang"/

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

    ctags --languages=Make \
      --tag-relative=no \
      "$PWD/Makefile" "$PWD/*.make" && mv "$PWD/tags" $MAKE_CTAGS && printf "Done: %s\n" "$MAKE_CTAGS has generated."
    ;;
  sh | bash | zsh)
    if [[ -e $SH_CTAGS ]]; then
      rm $SH_CTAGS
    fi

    ctags --languages=Sh -R "$PWD" && mv "$PWD/tags" $SH_CTAGS && printf "Done: %s\n" "$SH_CTAGS has generated."
    ;;
  automake | autoconf)
    if [[ -e $AUTOMAKE_CTAGS ]]; then
      rm $AUTOMAKE_CTAGS
    fi

    if [[ -e $AUTOCONF_CTAGS ]]; then
      rm $AUTOCONF_CTAGS
    fi

    ctags --languages=Automake -R "$PWD" && mv "$PWD/tags" $AUTOMAKE_CTAGS && printf "Done: %s\n" "$AUTOMAKE_CTAGS has generated."
    ctags --languages=Autoconf -R "$PWD" && mv "$PWD/tags" $AUTOCONF_CTAGS && printf "Done: %s\n" "$AUTOCONF_CTAGS has generated."

    ;;
  lua)
    if [[ -e $LUA_CTAGS ]]; then
      rm $LUA_CTAGS
    fi

    ctags --languages=Lua -R "$PWD" && mv "$PWD/tags" $LUA_CTAGS && printf "Done: %s\n" "$LUA_CTAGS has generated."
    ;;
  *)
    printf "Error: %s\n" "Parameters error" >&2
    exit 1
    ;;
  esac
done
