#!/bin/bash
#
# GenCtags: Generate ctags for specific languages.
# $@: languages
#
# By Ky9oss

C_CTAGS="./tagfiles/c/tags"
LUA_CTAGS="./tagfiles/lua/tags"
MAKE_CTAGS="./tagfiles/make/tags"
SH_CTAGS="./tagfiles/sh/tags"
AUTOMAKE_CTAGS="./tagfiles/automake/tags"
AUTOCONF_CTAGS="./tagfiles/autoconf/tags"
M4_CTAGS="./tagfiles/m4/tags"

for lang in "$@"; do
  lang=$(echo "$lang" | tr '[:upper:]' '[:lower:]')

  case $lang in
  c)
    mkdir -p ./tagfiles/c/
    find . -maxdepth 1 -type f -name "Makefile" | grep -q .

    if [[ 1 -eq $? ]]; then
      find "$PWD" -name '*.c' | while read src; do
        gcc -M -I/usr/include -I/usr/local/include -I"$PWD/include" "$src" 2>/dev/null
      done |
        sed -e 's/[\\ ]/\n/g' \
          -e '/^$/d' \
          -e 's/^.*\.o://g' | sort -u >all-includes.txt
    else
      find . -maxdepth 1 -type f -name "Makefile.am" | grep -q .
      if [[ 1 -eq $? ]]; then
        echo "TODO"
      else
        # tail -n 1 Makefile.am | grep PRECIOUS
        # if [[ 1 -eq $? ]]; then
        #   echo ".PRECIOUS: %.h" >>Makefile.am
        #   echo "GenCtags: Makefile.am has changed. Please recompile and run GenCtags again."
        #   exit
        # fi
        #
        # This is based on .deps from Autotools. Make sure compilation have done.
        touch temp-all-includes.txt
        pwd_escape=$(echo $PWD | sed -e 's/\//\\\//g')
        find $PWD -type d -name ".deps" | while read dir; do
          find $dir -type f -name "*.Po" | while read po_file; do
            cat "$po_file" | sed -e 's/[\\ ]/\n/g' \
              -e '/^$/d' \
              -e 's/^.*\.o://g' | sed -e 's/\(^[^\/].*.[ch]\)/'"$pwd_escape"'\/\1/g' | tr -d ":" | sort -u >>temp-all-includes.txt
          done
        done
        sort -u ./temp-all-includes.txt | uniq >./all-includes.txt
        rm ./temp-all-includes.txt
      fi
    fi

    if [[ -e $C_CTAGS ]]; then
      rm $C_CTAGS
    fi
    touch $C_CTAGS

    ctags --kinds-C=+px \
      --fields=+iaSK \
      --extras=+q \
      --totals=yes \
      -L all-includes.txt \
      --tag-relative=no \
      -f $C_CTAGS \
      -R "$PWD" && printf "Done: %s\n" "$C_CTAGS has generated."
    ;;
  make)
    mkdir -p ./tagfiles/make/

    if [[ -e $MAKE_CTAGS ]]; then
      rm $MAKE_CTAGS
    fi

    ctags --languages=Make \
      --fields=+K \
      --tag-relative=no \
      "$PWD/Makefile" "$PWD/*.make" "$PWD/*.mak" "$PWD/makefiles/*" && mv "$PWD/tags" $MAKE_CTAGS && printf "Done: %s\n" "$MAKE_CTAGS has generated."
    ;;
  sh | bash | zsh)
    mkdir -p ./tagfiles/sh/

    if [[ -e $SH_CTAGS ]]; then
      rm $SH_CTAGS
    fi

    ctags --languages=Sh \
      --fields=+K \
      -R "$PWD" && mv "$PWD/tags" $SH_CTAGS && printf "Done: %s\n" "$SH_CTAGS has generated."
    ;;
  automake | autoconf | autotools | m4)
    mkdir -p ./tagfiles/automake/
    mkdir -p ./tagfiles/autoconf/
    mkdir -p ./tagfiles/m4/

    if [[ -e $AUTOMAKE_CTAGS ]]; then
      rm $AUTOMAKE_CTAGS
    fi

    if [[ -e $AUTOCONF_CTAGS ]]; then
      rm $AUTOCONF_CTAGS
    fi

    if [[ -e $M4_CTAGS ]]; then
      rm $M4_CTAGS
    fi

    ctags --languages=Automake \
      --fields=+K \
      -R "$PWD" && mv "$PWD/tags" $AUTOMAKE_CTAGS && printf "Done: %s\n" "$AUTOMAKE_CTAGS has generated."
    ctags --languages=Autoconf \
      --fields=+K \
      -R "$PWD" && mv "$PWD/tags" $AUTOCONF_CTAGS && printf "Done: %s\n" "$AUTOCONF_CTAGS has generated."
    ctags --languages=M4 \
      --fields=+K \
      -R "$PWD" "$PWD/m4/" "/usr/local/share/aclocal/" "/usr/share/aclocal/" && mv "$PWD/tags" $M4_CTAGS && printf "Done: %s\n" "$M4_CTAGS has generated."

    ;;
  lua)
    mkdir -p ./tagfiles/lua/

    if [[ -e $LUA_CTAGS ]]; then
      rm $LUA_CTAGS
    fi

    ctags --languages=Lua \
      --fields=+K \
      -R "$PWD" && mv "$PWD/tags" $LUA_CTAGS && printf "Done: %s\n" "$LUA_CTAGS has generated."
    ;;
  *)
    printf "Error: %s\n" "Parameters error" >&2
    exit 1
    ;;
  esac
done
