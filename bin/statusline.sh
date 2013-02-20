#!/bin/sh

i3status --config ~/.i3/status | while :
do
  read line
  packages=$(cat ~/.paccount)

  if [ $packages == 0 ]
  then
    echo -e ":) | $line" || exit 1
  elif [ "$packages" -lt "20" ]
  then
    echo -e ":o $packages | $line" || exit 1
  else
    echo -e "D: $packages | $line" || exit 1
  fi
done
