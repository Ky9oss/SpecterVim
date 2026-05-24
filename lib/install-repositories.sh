#!/bin/bash
#
# This is used to clone some repositories for `ctags` when there are no source files to search the api you want.
# For example, after downloading luvit, only some binary files leave.
#
# By Ky9oss

mkdir -p ~/.spectervim/lua/
cd ~/.spectervim/lua/ || exit
git clone https://github.com/luvit/luvit
