#!/bin/bash
#
# By Ky9oss

INSTALL_MAN_PAGES=0
CTAGS_BASE=1

if [[ $CTAGS_BASE -eq 1 ]]; then
  mkdir -p autoconf
  mkdir -p automake

  # mkdir -p pkgconf
  # ctags --languages=Man -o ./man/pkgconf/tags ./pkg.m4.7

  ctags --options=${PWD}/../optlib/autoconf-gnu-manual.ctags --languages=AutoconfMan -o ${PWD}/autoconf/tags ${PWD}/autoconf.txt
  ctags --options=${PWD}/../optlib/automake-gnu-manual.ctags --languages=AutomakeMan -o ${PWD}/automake/tags ${PWD}/automake.txt

  # groff -Tascii -man pkg.m4.7 > pkg.m4
  # nroff -man yourfile.1 > output.txt
  # man ./pkg.m4.7 | col -b > pkg-m4.txt
  cp /usr/share/man/man7/pkg.m4.7.gz ./ && gunzip pkg.m4.7.gz
  man ./pkg.m4.7 | col -b >pkg-m4.txt
  rm ./pkg.m4.7 ./pkg.m4.7.gz

  ctags --options=${PWD}/../optlib/pkgconf-manual.ctags --languages=PkgconfMan -o ${PWD}/pkgconf/tags ${PWD}/pkg-m4.txt

  # ctags -R --languages=man /usr/share/man
fi

normalize() {

  local input="$1"

  input="$(echo "$input" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
  input="$(echo "$input" | tr '[:upper:]' '[:lower:]')"
  input="$(echo "$input" | tr -s ' ')"
  input="$(echo "$input" | sed 's/[^a-z0-9_ ]/_/g')"

  echo $input
}

if [[ $INSTALL_MAN_PAGES -eq 1 ]]; then
  git clone https://github.com/mkerrisk/man-pages
  cd man-pages || return
  make install-man2 prefix="${PWD}/../"
  make install-man3 prefix="${PWD}/../"
  cd ..

  for file in ./share/man/man2/*; do
    if [ -f "$file" ]; then
      filename=$(basename "$file")
      newname="$filename.txt"
      dirname=$(normalize "$filename")
      mkdir -p man/$dirname
      man "$file" | col -b >"man/$dirname/$newname"
    fi
  done

  for file in ./share/man/man3/*; do
    if [ -f "$file" ]; then
      filename=$(basename "$file")
      newname="$filename.txt"
      dirname=$(normalize "$filename")
      mkdir -p man/$dirname
      man "$file" | col -b >"man/$dirname/$newname"
    fi
  done
fi

