#!/bin/bash
#
# Run osc52-copy.sh in a hidden pane in tmux.
# Use it when tmux osc52 is unavailable due to unknown errors.
#
# By Ky9oss

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OSC52_SCRIPT="$CURRENT_DIR/osc52-copy.sh"

content=$(cat)

if [[ -n $content ]]; then
  # load to tmux buffer
  echo "$content" | tmux load-buffer -w - 
fi

old_pane=$(tmux display-message -p "#{pane_id}")

list_panes=$(tmux list-panes -F "#{pane_width}:#{pane_id}")
readarray arr <<<"$list_panes"

for item in "${arr[@]}"; do
  if [[ "$item" =~ ^1:([^[:space:]]+) ]]; then
    new_pane=${BASH_REMATCH[1]}
  fi
done

if [[ -z $new_pane ]]; then
  new_pane=$(tmux split-window -h -l 1 -P -F "#{pane_id}" 'bash --noprofile --norc') # use clean bash
  tmux select-pane -t "$old_pane"
fi

# Warning: `. script.sh` will run scripts in the current progress; `./script.sh` run scripts in **child** process
if [[ -x $OSC52_SCRIPT ]]; then
  tmux send-keys -t "$new_pane" ". $OSC52_SCRIPT" Enter 
elif [[ -f $OSC52_SCRIPT ]]; then
  tmux send-keys -t "$new_pane" "chmod +x $OSC52_SCRIPT && . $OSC52_SCRIPT" Enter
else
  printf "File does not exist!";
fi

# sleep 0.02
# tmux kill-pane -t "$new_pane"
