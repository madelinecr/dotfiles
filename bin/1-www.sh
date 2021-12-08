#!/usr/bin/bash

i3-msg "append_layout $HOME/.i3/1-www.json"

firefox & disown
sleep 0.2
for value in {1..2}
do
  urxvt & disown
  sleep 0.1
done
