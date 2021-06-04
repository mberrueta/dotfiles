#!/bin/sh

tmux new-window -n 'api_scripts' -c ~/code/packet/useful_scripts 
tmux select-window -t 'api_scripts'
tmux split-window -h 
tmux split-window -v -l 50
tmux select-pane -t 2
tmux send-keys 'api_pod_exec rc' C-m
tmux select-pane -t 1
tmux send-keys 'cd ~/code/packet/useful_scripts' C-m
tmux select-pane -t 0
tmux send-keys 'vim' C-m
