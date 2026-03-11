#!/bin/bash
#
# Run bash scripts with tmux
# $1: Script's filename

old_pane=$(tmux display-message -p "#{pane_id}")

list_panes=$(tmux list-panes -F "#{pane_width}:#{pane_id}")
readarray arr <<<"$list_panes"

for item in "${arr[@]}"; do
  if [[ "$item" =~ 45:([^[:space:]]+) ]]; then
    new_pane=${BASH_REMATCH[1]}
  fi
done

if [[ -z $new_pane ]]; then
  new_pane=$(tmux split-window -h -l 45 -P -F "#{pane_id}")
  tmux select-pane -t "$old_pane"
fi

if [[ -x $1 ]]; then
  tmux send-keys -t "$new_pane" "$1" Enter
elif [[ -f $1 ]]; then
  tmux send-keys -t "$new_pane" "chmod +x $1 && $1" Enter
else
  printf "File does not exist!";
fi
