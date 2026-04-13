#!/bin/bash

mkdir -p autoconf
mkdir -p automake

mkdir -p pkg-config
ctags --languages=Man -o ./man/pkgconf/tags ./pkg.m4.7

ctags --options=${PWD}/../optlib/autoconf-gnu-manual.ctags --languages=AutoconfMan -o ${PWD}/autoconf/tags ${PWD}/autoconf.txt
ctags --options=${PWD}/../optlib/automake-gnu-manual.ctags --languages=AutomakeMan -o ${PWD}/automake/tags ${PWD}/automake.txt

# groff -Tascii -man pkg.m4.7 > pkg.m4
# nroff -man yourfile.1 > output.txt
# man ./pkg.m4.7 | col -b > pkg-m4.txt
cp /usr/share/man/man7/pkg.m4.7.gz ./ && gunzip pkg.m4.7.gz
man ./pkg.m4.7 | col -b > pkg-m4.txt
rm ./pkg.m4.7

ctags --options=${PWD}/../optlib/pkgconf-manual.ctags --languages=PkgconfMan -o ${PWD}/pkgconf/tags ${PWD}/pkg-m4.txt
