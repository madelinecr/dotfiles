#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0) && pwd)
SOURCE_DIR=$SCRIPT_DIR/config
BIN_DIR=$SCRIPT_DIR/bin
TARGET_DIR=$HOME

MANIFEST='manifest'

args=("$@")
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
function create_symlink {
  source=$1
  target=$2
  if [ -h $target ]; then
    echo -e $(yellow "Existing symlink: $target")
  elif [ ! -e $source ]; then
    echo -e $(red "Error - source does not exist: $source")
    echo -e "Correct path or remove from $MANIFEST to continue."
    exit
  elif [ -e $target ]; then
    echo -e $(red "Error - regular file at target location $target exists")
    echo -e $(red "Remove the obstruction and re-run this script to continue.")
    exit
  else
    echo -e $(green "Creating symlink: $target")

    if ! $dryrun; then
      ln -s $source $target
    fi
  fi
}

# Sanely removes symlinks.
# Arguments: $1 = target
function rm_symlink {
  target=$1

  if [ -h $target ]; then
    echo -e $(green "Removing symlink: $target")

    if ! $dryrun; then
      rm $target
    fi
  elif [ -e $target ]; then
    echo -e $(red "Warning - Regular file at target location: $target")
  else
    echo -e $(yellow "Nothing to do for: $target")
  fi
}

# 'Installs' the symlinks to the user's home directory.
function install {
  echo "Installing dotfile symlinks..."
  while read path; do
    create_symlink $SOURCE_DIR/$path $TARGET_DIR/.$path
  done < manifest

  echo "Installing binary symlinks..."
  for file in $(ls $BIN_DIR); do
    if [ ! -d $TARGET_DIR/bin/ ]; then
      mkdir $TARGET_DIR/bin/
    fi
    create_symlink $BIN_DIR/$file $TARGET_DIR/bin/$file
  done

  echo "Initializing git submodules..."
  if ! $dryrun; then
    git submodule update --init --recursive
  fi
  echo "Done"
}

# Checks for symlinks this script might have created and cleans them up.
function uninstall {
  echo "Uninstalling dotfile symlinks..."
  while read path; do
    rm_symlink $TARGET_DIR/.$path
  done < manifest

  echo "Uninstalling binary symlinks..."
  for file in $(ls $BIN_DIR); do
    rm_symlink $TARGET_DIR/bin/$file
  done
  echo "Done"
}

function usage {
  echo "Usage: $script [<command>] [-h|--help] [-d|--dry-run] [-s|--sandbox]"
  echo "Where <command> is 'install', or 'uninstall'"
  exit 0
}

# Parse flags
for (( i = ${#args[@]} - 1; i >= 0; i-- )); do
  case ${args[i]} in
    -d | --dry-run)
      echo "(DRY RUN: No changes will be made)"
      dryrun=true
      unset args[i];;
    -s | --sandbox)
      echo "(SANDBOX: Symlinking in sandbox folder)"
      TARGET_DIR=$SCRIPT_DIR/sandbox
      if [ ! -d $TARGET_DIR ]; then
        mkdir $TARGET_DIR
      fi
      unset args[i];;
    -h | --help)
      usage
      unset args[i];;
    -*)
      echo "Unrecognized option: ${args[i]}"
      usage
      unset args[i];;
  esac
done

# Check number of arguments
if [ ${#args[@]} -gt 1 ]; then
  usage
fi

# Script start
case ${args[0]} in
  ''         ) install;;
  'install'  ) install;;
  'uninstall') uninstall;;
  *          ) usage;;
esac
