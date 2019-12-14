#!/bin/sh

SESSION=monitorlong

if ! tmux has-session -t $SESSION &> /dev/null; then
  tmux new-session -s $SESSION -d htop
  tmux split-window -v watch -n 0.1 iostat
  tmux split-window -v watch -n 0.1 w
  tmux split-window -v watch -n 0.1 ls -al /dev/pts*
fi

tmux attach-session -t $SESSION
