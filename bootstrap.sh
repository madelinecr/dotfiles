#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0) && pwd)
SOURCE_DIR=$SCRIPT_DIR/config
BIN_DIR=$SCRIPT_DIR/bin
TARGET_DIR=$HOME

MANIFEST='manifest'

dryrun=false

function green {
  echo "\033[32m$1\033[0m"
} 
function yellow {
  echo "\033[33m$1\033[0m"
}

function red {
  echo "\033[31m$1\033[0m"
}

# Sanely and safely creates symlinks.
# Arguments: $1 = source, $2 = target
function symlink {
  source=$1
  target=$2
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
    if ! $dryrun; then
      ln -s $source $target
    fi
  fi
}

# Sanely removes symlinks.
# Arguments: $1 = target
function rm_symlink {
  target=$1
  if [ -h $target ]
  then
    echo -e "Removing symlink $(green $target)"
    rm $target
  elif [ -e $target ]
  then
    echo -e "Warning: $(yellow $target) is a regular file, skipping over"
  else
    echo -e "Nothing found at $(green $target), skipping over"
  fi
}

# 'Installs' the symlinks to the user's home directory.
function install {
  echo -e $(green " --- Symlinking Configuration Files --- ")
  while read file; do
    symlink $SOURCE_DIR/$file $TARGET_DIR/.$file
  done < manifest

  echo -e $(green " --- Symlinking Binary Files --- ")
  for file in $(ls $BIN_DIR); do
    symlink $BIN_DIR/$file $TARGET_DIR/bin/$file
  done
  echo -e "Install finished."
}

# Checks for symlinks this script might have created and cleans them up.
function uninstall {
  echo -e $(green " --- Removing Configuration Symlinks --- ")
  while read file; do
    rm_symlink $TARGET_DIR/.$file
  done < manifest

  echo -e $(green " --- Removing Binary Symlinks --- ")
  for file in $(ls $BIN_DIR); do
    rm_symlink $TARGET_DIR/bin/$file
  done
  echo -e "Uninstall finished. Feel cleaner?"
}

# Script start
case $1 in
  'install')
    install
    ;;
  'uninstall')
    uninstall
    ;;
  *)
    install
    ;;
esac
