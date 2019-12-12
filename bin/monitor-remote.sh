#!/usr/bin/bash

i3-msg "append_layout $HOME/.i3/monitor-remote.json"

i3-sensible-terminal -e ssh publicserver-01 & disown
sleep 0.1
i3-sensible-terminal -e ssh obscura-01 & disown
sleep 0.1
i3-sensible-terminal -e ssh kryten & disown
sleep 0.1
i3-sensible-terminal & disown
sleep 0.1
