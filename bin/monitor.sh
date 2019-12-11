#!/usr/bin/bash

i3-msg "append_layout $HOME/.i3/monitor.json"

for value in {1..3}
do
  i3-sensible-terminal -e ssh publicserver-01 & disown
  sleep 0.1
done

for value in {1..3}
do
  i3-sensible-terminal -e ssh obscura-01 & disown
  sleep 0.1
done

for value in {1..3}
do
  i3-sensible-terminal -e ssh kryten & disown
  sleep 0.1
done
