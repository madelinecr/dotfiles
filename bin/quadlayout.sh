#!/usr/bin/bash

i3-msg "append_layout $HOME/.i3/quadlayout.json"

for value in {1..8}
do
  i3-sensible-terminal & disown
done
