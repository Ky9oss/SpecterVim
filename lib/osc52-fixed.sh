#!/bin/bash
#
# Fix osc52 bug in tmux
# stdin: content
#
# By Ky9oss

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

content=$(cat)

if [[ -n $content ]]; then
  # load to tmux buffer
  echo "$content" | tmux load-buffer -w - 

  s1="$CURRENT_DIR/runscript-in-hidden-pane.sh"
  s2="$CURRENT_DIR/osc52-copy.sh"

  # run shell which get 
  tmux run-shell -b "$s1 $s2"
fi
