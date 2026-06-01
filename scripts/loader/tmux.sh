#!/bin/bash
#
# Run bash scripts in tmux
# $1:
#   - Description: Script's filename
#   - Type: string | nil
# $2:
#   - Description: Horizontal or vertical split
#   - Type: 0(default) | 1 | nil

# Get panes
old_pane=$(tmux display-message -p "#{pane_id}")

# Horizontal split
if [[ -z $2 || $2 -eq 0 ]]; then

  list_panes=$(tmux list-panes -F "#{pane_width}:#{pane_id}")
  readarray arr <<<"$list_panes"
  for item in "${arr[@]}"; do
    if [[ "$item" =~ 45:([^[:space:]]+) ]]; then
      new_pane=${BASH_REMATCH[1]}
    fi
  done

  # Create a new pane if there is not any pane
  if [[ -z $new_pane ]]; then
    new_pane=$(tmux split-window -h -l 45 -P -F "#{pane_id}")
    tmux select-pane -t "$old_pane"
  fi

# Vertical split
elif [[ $2 -eq 1 ]]; then 

  list_panes=$(tmux list-panes -F "#{pane_height}:#{pane_id}")
  readarray arr <<<"$list_panes"
  for item in "${arr[@]}"; do
    if [[ "$item" =~ 10:([^[:space:]]+) ]]; then
      new_pane=${BASH_REMATCH[1]}
    fi
  done

  # Create a new pane if there is not any pane
  if [[ -z $new_pane ]]; then
    new_pane=$(tmux split-window -v -l 10 -P -F "#{pane_id}")
    tmux select-pane -t "$old_pane"
  fi
else
  print "Failed to read the parameter \$2($2). Expected 0 | 1 | nil."
  exit 1

fi

# Exit if no param
if [[ -z $1 ]]; then
  exit 0
else
  # Run scripts
  if [[ -x $1 ]]; then
    tmux send-keys -t "$new_pane" "$1" Enter
  elif [[ -f $1 ]]; then
    tmux send-keys -t "$new_pane" "chmod +x $1 && $1" Enter
  else
    printf "The script is not valid!"
  fi
fi
