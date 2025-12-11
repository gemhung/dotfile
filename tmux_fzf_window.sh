#!/bin/bash

window_list=$(tmux list-windows -F '#{window_index} #{window_name}')
window_index=$(echo "$window_list" | fzf | awk '{ print $1 }')
tmux select-window -t $window_index

