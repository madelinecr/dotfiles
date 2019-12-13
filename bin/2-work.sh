#!/usr/bin/bash

i3-msg "append_layout $HOME/.i3/2-work.json"

gvim & disown
sleep 0.2
for value in {1..3}
do
  i3-sensible-terminal & disown
  sleep 0.1
done
