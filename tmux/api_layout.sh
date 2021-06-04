#!/bin/sh

tmux new-window -n 'api' -c ~/code/packet/api 
tmux select-window -t 'api'
tmux split-window -h 
tmux split-window -v -l 10
tmux select-pane -t 2
tmux send-keys 'cd ~/code/packet' C-m
tmux send-keys 'docker-compose up' C-m
tmux select-pane -t 1
tmux send-keys 'cd ~/code/packet/api' C-m
tmux select-pane -t 0
tmux send-keys 'vim' C-m
