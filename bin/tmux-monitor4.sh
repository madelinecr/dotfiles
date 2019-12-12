#!/bin/sh

tmux new-session -s "monitorlong" -d htop
tmux split-window -v watch -n 0.1 iostat
tmux split-window -v watch -n 0.1 w
tmux split-window -v watch -n 0.1 ls -al /dev/pts*
tmux attach-session -t "monitorlong"
