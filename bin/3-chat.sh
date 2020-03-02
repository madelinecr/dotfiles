#!/usr/bin/bash

i3-msg "append_layout $HOME/.i3/3-chat.json"

discord & disown
sleep 0.1
keybase-gui & disown
