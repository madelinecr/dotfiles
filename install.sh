#!/bin/bash

BASEDIR=$(cd $(dirname $0) && pwd)
CONFIGDIR=$BASEDIR/config

FILE_ERROR='File exists, cowardly exiting. Fix obstruction and run this script
again to refresh the symlinks.'

function green {
  echo "\033[32m$1\033[0m"
} 
function yellow {
  echo "\033[33m$1\033[0m"
}

function red {
  echo "\033[31m$1\033[0m"
}

function symlink {
  while read filename; do
    target=$HOME/.$filename
    if [ -e $target ] && [ ! -h $target ]
    then
      echo -e "Error: $(red $target) exists "
      echo "Cowardly dying and refusing to break your local config."
      echo "Clear the obstruction and run this script again to finish up."
      exit
    elif [ -h $target ]
    then
      echo -e "Skipping existing symlink $(yellow $target)"
    else
      echo -e "Linking symlink $(green $target)"
      ln -s $CONFIGDIR/$filename $target
    fi
  done < manifest

  # TODO: Symlink executables in bin to ~/bin
}

function uninstall {
  while read filename; do
    target=$HOME/.$filename
    if [ -h $target ]
    then
      echo -e "Removing symlink $(green $target)"
      rm $target
    else
      echo -e "Warning: $(yellow $target) exists, skipping over"
    fi
  done < manifest
  echo -e "Uninstall finished. Feel cleaner?"
}

case $1 in
  'install')
    symlink
    ;;
  'uninstall')
    uninstall
    ;;
  *)
    symlink
    ;;
esac
