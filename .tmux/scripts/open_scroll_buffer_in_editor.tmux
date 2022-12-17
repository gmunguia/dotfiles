#!/usr/bin/env fish

mkdir -p /tmp/tmux-buffers
set window_index (tmux display -p '#{window_index}')
set buffer_file_name "/tmp/tmux-buffers/$window_index"
tmux capture-pane -S -10000
tmux save-buffer $buffer_file_name
tmux new-window "hx $buffer_file_name"
